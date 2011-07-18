require File.dirname(__FILE__) + '/../test_helper'
require 'usr_controller'
require 'usr_notify'

# Raise errors beyond the default web-based presentation
class UsrController; def rescue_action(e) raise e end; end

class UsrControllerTest < Test::Unit::TestCase
  self.use_transactional_fixtures = false
  fixtures :usrs

  def setup
    @controller = UsrController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
    @request.host = "localhost"
    ActionMailer::Base.inject_one_error = false
    ActionMailer::Base.deliveries = []
  end
  
  def test_login__valid_login__redirects_as_specified
    @request.session[:return_to] = "/bogus/location"
    post :login, :usr => { :login => "tesla", :password => "atest" }
    assert_logged_in usrs(:tesla)
    assert_response :redirect
    assert_equal "http://#{@request.host}/bogus/location", @response.redirect_url
  end

  def test_login__valid_login__shows_welcome_as_default
    post :login, :usr => { :login => "tesla", :password => "atest" }
    assert_logged_in usrs(:tesla)
    assert_response :redirect
    assert_equal @controller.url_for(:action => 'welcome'), @response.redirect_url
  end

  def test_login__wrong_password
    post :login, :usr => { :login => "tesla", :password => "wrong password" }
    assert_not_logged_in
    assert_template 'login'
    assert_contains "Login failed", flash['message']
  end

  def test_login__wrong_login
    post :login, :usr => { :login => "wrong login", :password => "atest" }
    assert_not_logged_in
    assert_template 'login'
    assert_contains "Login failed", flash['message']
  end

  def test_login__deleted_usr_cant_login
    post :login, :usr => { :login => "deleted_tesla", :password => "atest" }
    assert_not_logged_in
    assert_template 'login'
    assert_contains "Login failed", flash['message']
  end
  
  def test_signup
    post_signup :login => "newusr",
                :password => "password", :password_confirmation => "password",
                :email => "newemail@example.com"
    assert_not_logged_in
    assert_redirected_to_login
    assert_equal 1, ActionMailer::Base.deliveries.size

    mail = ActionMailer::Base.deliveries[0]
    assert_equal "newemail@example.com", mail.to_addrs[0].to_s
    assert_match /login:\s+\w+\n/, mail.encoded
    assert_match /password:\s+\w+\n/, mail.encoded
    usr = Usr.find_by_email("newemail@example.com")
    assert_match /usr\[id\]=#{usr.id}/, mail.encoded
    assert_match /key=#{usr.security_token}/, mail.encoded
    assert !usr.verified
  end


  def test_signup__cannot_set_arbitrary_attributes
    post_signup :login => "newusr",
                :password => "password", :password_confirmation => "password",
                :email => "skunk@example.com",
                :verified => '1',
                :role => 'superadmin'
    usr = Usr.find_by_email("skunk@example.com")
    assert !usr.verified
    assert_nil usr.role
  end

  def test_signup__validates_password_min_length
    post_signup :login => "tesla_rhea", :password => "bad", :password_confirmation => "bad", :email => "someone@example.com"
    assert_password_validation_fails
  end

  def test_signup__raises_delivery_errors
    ActionMailer::Base.inject_one_error = true
    post_signup :login => "newtesla",
                :password => "newpassword", :password_confirmation => "newpassword",
                :email => "newtesla@example.com"
    assert_not_logged_in
    assert_equal 0, ActionMailer::Base.deliveries.size
    assert_contains "confirmation email not sent", flash['message']
  end

  def test_signup__mismatched_passwords
    post :signup, :usr => { :login => "newtesla", :password => "newpassword", :password_confirmation => "wrong" }
    usr = assigns(:usr)
    assert_equal 1, usr.errors.size
    assert_not_nil usr.errors['password']
  end
  
  def test_signup__bad_login
    post_signup :login => "yo", :password => "newpassword", :password_confirmation => "newpassword"
    usr = assigns(:usr)
    assert_equal 1, usr.errors.size
    assert_not_nil usr.errors['login']
  end

  def test_welcome
    usr = usrs(:unverified_usr)
    get :welcome, :usr=> { :id => usr.id }, :key => usr.security_token
    usr.reload
    assert usr.verified
    assert_logged_in( usr )
    assert usr.token_expired?
  end

  def test_welcome__fails_if_expired_token
    usr = usrs(:unverified_usr)
    Clock.advance_by_days 2 # now past verification deadline
    get :welcome, :usr=> { :id => usr.id }, :key => usr.security_token
    usr.reload
    assert !usr.verified
    assert_not_logged_in
  end

  def test_welcome__fails_if_bad_token
    usr = usrs(:unverified_usr)
    Clock.time = Time.now # now before deadline, but with bad token
    get :welcome, :usr=> { :id => usr.id }, :key => "boguskey"
    usr.reload
    assert !usr.verified
    assert_not_logged_in
  end

  def test_edit
    tesla = usrs(:tesla)
    set_logged_in tesla
    post :edit, :usr => { :first_name => "Bob", :form => "edit" }
    tesla.reload
    assert_equal tesla.first_name, "Bob"
  end

  def test_delete
    usr = usrs(:deletable_usr)
    set_logged_in usr
    post :edit, "usr" => { "form" => "delete" }
    usr.reload
    assert usr.deleted
    assert_not_logged_in
  end

  def test_change_password
    usr = usrs(:tesla)
    set_logged_in usr
    post :change_password, :usr => { :password => "changed_password", :password_onfirmation => "changed_password" }
    assert_equal 1, ActionMailer::Base.deliveries.size
    mail = ActionMailer::Base.deliveries[0]
    assert_equal "tesla@example.com", mail.to_addrs[0].to_s
    assert_match /login:\s+\w+\n/, mail.encoded
    assert_match /password:\s+\w+\n/, mail.encoded
    assert_equal usr, Usr.authenticate(usr.login, 'changed_password')
  end

  def test_change_password__confirms_password
    set_logged_in usrs(:tesla)
    post :change_password, :usr => { :password => "bad", :password_confirmation => "bad" }
    usr = assigns(:usr)
    assert_equal 1, usr.errors.size
    assert_not_nil usr.errors['password']
    assert_response :success
    assert_equal 0, ActionMailer::Base.deliveries.size
  end

  def test_change_password__succeeds_despite_delivery_errors
    set_logged_in usrs(:tesla)
    ActionMailer::Base.inject_one_error = true
    post :change_password, :usr => { :password => "changed_password", :password_confirmation => "changed_password" }
    assert_equal 0, ActionMailer::Base.deliveries.size
    assert_equal usrs(:tesla), Usr.authenticate(usrs(:tesla).login, 'changed_password')
  end

  def test_forgot_password__when_logged_in_redirects_to_change_password
    usr = usrs(:tesla)
    set_logged_in usr
    post :forgot_password, :usr => { :email => usr.email }
    assert_equal 0, ActionMailer::Base.deliveries.size
    assert_response :redirect
    assert_equal @controller.url_for(:action => "change_password"), @response.redirect_url
  end

  def test_forgot_password__requires_valid_email_address
    post :forgot_password, :usr => { :email => "" }
    assert_equal 0, ActionMailer::Base.deliveries.size
    assert_match /Please enter a valid email address./, @response.body
  end

  def test_forgot_password__ignores_unknown_email_address
    post :forgot_password, :usr => { :email => "unknown_email@example.com" }
    assert_equal 0, ActionMailer::Base.deliveries.size
  end

  def test_forgot_password__reports_delivery_error
    ActionMailer::Base.inject_one_error = true
    post :forgot_password, :usr => { :email => usrs(:tesla).email }
    assert_equal 0, ActionMailer::Base.deliveries.size
    assert_match /Your password could not be emailed/, @response.body
  end

  def test_invalid_login
    post :login, :usr => { :login => "tesla", :password => "not_correct" }
    assert_not_logged_in
    assert_response :success
    assert_template 'login'
  end
  
  def test_logout
    set_logged_in usrs(:tesla)
    get :logout
    assert_not_logged_in
  end

  private

  def set_logged_in( usr )
    @request.session[:usr_id] = usr.id
  end

  def assert_logged_in( usr )
    assert_equal usr.id, @request.session[:usr_id]
    assert_equal usr, assigns(:current_usr)
  end

  def assert_not_logged_in
    assert_nil @request.session[:usr_id]
    assert_nil assigns(:current_usr)
  end

  def assert_redirected_to_login
    assert_equal @controller.url_for(:action => "login"), @response.redirect_url
  end

  def post_signup( usr_params )
    post :signup, "usr" => usr_params
  end

  def assert_password_validation_fails
    usr = assigns(:usr)
    assert_equal 1, usr.errors.size
    assert_not_nil usr.errors['password']
    assert_response :success
    assert_equal 0, ActionMailer::Base.deliveries.size
  end

  def assert_contains( target, container )
    assert !container.nil?, %Q( Failed to find "#{target}" in nil String )
    assert container.include?(target)
  end

end
