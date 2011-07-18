# Provides signup and login actions for every Usr.
# Most of the code here came from LoginSugar:
# http://wiki.rubyonrails.org/rails/pages/LoginSugar
class UsrController < ApplicationController

  layout  'application'

  skip_before_filter :authenticate_usr, :only => [ :login, :signup, :forgot_password, :logout ]

  def login
    return if generate_blank_form
    @usr = Usr.new(params['usr'])
    usr = Usr.authenticate(params['usr']['login'], params['usr']['password'])
    if usr
      @current_usr = usr
      session[:usr_id] = usr.id
      flash['notice'] = 'Login succeeded'
      redirect_to(:controller => 'sttc', :action => 'instructions')
    else
      @login = params['usr']['login']
      flash['message'] = 'Login failed'
    end
  end

  def signup
    return if generate_blank_form
    @usr = Usr.new(
      :login => params['usr'][:login],
      :password => params['usr'][:password],
      :password_confirmation => params['usr'][:password_confirmation],
      :email => params['usr'][:email],
      :first_name => params['usr'][:first_name],
      :last_name => params['usr'][:last_name]
    )
    begin
      Usr.transaction do
        @usr.password_needs_confirmation = true
        if @usr.save
          key = @usr.generate_security_token
          url = url_for(:action => 'welcome')
          url += "?usr[id]=#{@usr.id}&key=#{key}"
          UsrNotify.deliver_signup(@usr, params['usr']['password'], url)
          flash['notice'] = 'Signup successful! Please check your email.'
          redirect_to(:action => 'after_signup', :controller => 'sttc')
        end
      end
    rescue Exception => ex
      report_exception ex
      flash['message'] = 'Error creating account: confirmation email not sent'
    end
  end

  def logout
    session[:usr_id] = nil
    @current_usr = nil
    redirect_to "/"
  end

  def change_password
    return if generate_filled_in
    params['usr'].delete('form')
    begin
      @usr.change_password(params['usr']['password'], params['usr']['password_confirmation'])
      @usr.save!
    rescue Exception => ex
      report_exception ex
      flash.now['message'] = 'Your password could not be changed at this time. Please retry.'
      render and return
    end
    begin
      UsrNotify.deliver_change_password(@usr, params['usr']['password'])
      redirect_to "/"
    rescue Exception => ex
      report_exception ex
    end

  end

  def forgot_password
    if authenticated_usr?
      flash['message'] = 'You are currently logged in. You may change your password now.'
      redirect_to :action => 'change_password'
      return
    end

    return if generate_blank_form

    if params['usr']['email'].empty?
      flash.now['message'] = 'Please enter a valid email address.'
    elsif (usr = Usr.find_by_email(params['usr']['email'])).nil?
      flash.now['message'] = "We could not find a usr with the email address #{CGI.escapeHTML(params['usr']['email'])}"
    else
      begin
        Usr.transaction do
          key = usr.generate_security_token
          url = url_for(:action => 'change_password')
          url += "?usr[id]=#{usr.id}&key=#{key}"
          UsrNotify.deliver_forgot_password(usr, url)
          flash['notice'] = "Instructions on resetting your password have been emailed to #{CGI.escapeHTML(params['usr']['email'])}."
          unless authenticated_usr?
#            redirect_to :action => 'login'
            redirect_to(:controller => "sttc/forgot")
            return
          end
          redirect_to "/"
        end
      rescue Exception => ex
        report_exception ex
        flash.now['message'] = "Your password could not be emailed to #{CGI.escapeHTML(params['usr']['email'])}"
      end
    end
  end

  def edit
    return if generate_filled_in
    if params['usr']['form']
      form = params['usr'].delete('form')
      begin
        case form
        when "edit"
          unclean_params = params['usr']
          usr_params = unclean_params.delete_if { |k,v| not Usr::CHANGEABLE_FIELDS.include?(k) }
          @usr.attributes = usr_params
          @usr.save
          flash.now['notice'] = "Usr has been updated."
        when "change_password"
          change_password
        when "delete"
          delete
        else
          raise "unknown edit action"
        end
      rescue Exception => ex
        logger.warn ex
        logger.warn ex.backtrace
      end
    end
  end

  def delete
    @usr = @current_usr || Usr.find_by_id( session[:usr_id] )
    begin
      @usr.update_attribute( :deleted, true )
      logout
    rescue Exception => ex
      flash.now['message'] = "Error: #{@ex}."
      redirect_back_or_default :action => 'welcome'
    end
  end

  def welcome
  end

  protected

  def protect?(action)
    if ['login', 'signup', 'forgot_password'].include?(action)
      return false
    else
      return true
    end
  end

  # Generate a template usr for certain actions on get
  def generate_blank_form
    case request.method
    when :get
      @usr = Usr.new
      render
      return true
    end
    return false
  end

  # Generate a template usr for certain actions on get
  def generate_filled_in
    @usr = @current_usr || Usr.find_by_id( session[:usr_id] )
    case request.method
    when :get
      render
      return true
    end
    return false
  end

  def report_exception( ex )
    logger.warn ex
    logger.warn ex.backtrace.join("\n")
  end

end
