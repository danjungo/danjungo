require File.dirname(__FILE__) + '/../test_helper'
require 'usr_controller'
require 'usr_notify'

class UsrSystemTest < ActionController::IntegrationTest
  self.use_transactional_fixtures = false
  fixtures :usrs

  def setup
    ActionMailer::Base.inject_one_error = false
    ActionMailer::Base.deliveries = []
  end

  def test_signup_and_verify
    Clock.time = Time.now
    post url_for( :controller => 'usr', :action => 'signup'),
         :usr => { :login => "newusr",
                    :password => "password", :password_confirmation => "password",
                    :email => "newemail@example.com" }
           
    assert_not_logged_in
    assert_redirected_to_login
    assert_equal 1, ActionMailer::Base.deliveries.size

    mail = ActionMailer::Base.deliveries[0]
    assert_equal "newemail@example.com", mail.to_addrs[0].to_s
    assert_match /login:\s+\w+\n/, mail.encoded
    assert_match /password:\s+\w+\n/, mail.encoded
    mail.encoded =~ /usr\[id\]=(\d+)&key=(.*?)"/
    id = $1
    key = $2

    Clock.advance_by_days 2 # now past verification deadline

    get url_for( :controller => 'usr', :action => 'welcome'),
        :usr=> { :id => id }, :key => key
    assert_redirected_to_login
    usr = Usr.find_by_id id
    assert !usr.verified
    assert_not_logged_in

    Clock.time = Time.now # now before deadline
    get url_for( :controller => 'usr', :action => 'welcome'),
        :usr=> { :id => "#{id}" }, :key => "boguskey"
    assert_redirected_to_login
    assert_not_logged_in
    usr.reload
    assert !usr.verified

    get url_for( :controller => 'usr', :action => 'welcome'),
        :usr=> { :id => "#{usr.id}" }, :key => "#{key}"
    assert_response :success
    usr.reload
    assert usr.verified
    assert_logged_in( usr )
  end

  def test_forgot_password__allows_change_password_after_mailing_key
    usr = usrs(:tesla)
    post url_for( :controller => 'usr', :action => 'forgot_password'), :usr => { :email => usr.email }
    assert_equal 1, ActionMailer::Base.deliveries.size
    mail = ActionMailer::Base.deliveries[0]
    assert_equal usrs(:tesla).email, mail.to_addrs[0].to_s
    mail.encoded =~ /usr\[id\]=(.*?)&key=(.*?)"/
    id = $1
    key = $2
    post url_for( :controller => 'usr', :action => 'change_password'),
         :usr => { :password => "newpassword",
                    :password_confirmation => "newpassword",
                    :id => id },
         :key => key
    usr.reload
    assert_logged_in usr
    assert_equal usr, Usr.authenticate(usr.login, 'newpassword')
  end



  private
  def assert_logged_in( usr )
    assert_equal usr.id, request.session[:usr_id]
    assert_equal usr, assigns(:current_usr)
  end

  def assert_not_logged_in
    assert_nil request.session[:usr_id]
    assert_nil assigns(:current_usr)
  end

  def assert_redirected_to_login
    assert_response :redirect
    assert_equal controller.url_for(:action => "login"), response.redirect_url
  end

end