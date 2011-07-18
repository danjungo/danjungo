class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :repel_anon
  def repel_anon
    return if defined?(current_user).nil?
    return if current_user.nil?
    if current_user.login == "anonymous"
      session[:user] = nil
      current_user = nil
      flash[:error] = "You are Anonymous. You cannot do much. We want you to Signup"
      redirect_to :controller => 'users', :action => 'new'
      return false
    end # if
  end # def

end # class
