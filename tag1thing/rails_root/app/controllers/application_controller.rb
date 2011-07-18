# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  before_filter :set_theme
  before_filter :set_facebook_session
  helper_method :facebook_session
  require 'hpricot'

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  # Useful syntax for collecting Theme names:
  # cd /pt/t1/public/
  # irb
  # Dir.glob('jquery_ui172/css/*')
  # Dir.glob('jquery_ui172/css/*').each{ |themedir| p themedir }
  before_filter :must_login
  def must_login
    # If you are not logged in, we login you as Guest.
    (session[:usrnm]= session[:opndd]= "Guest") if session[:opndd].nil?
  end

  private

  def ddelnil!(a)
    a.delete_if{ |m| m.nil? }
    return a
  end

  def set_theme
    session[:ccolor_theme]= "black-tie" if session[:ccolor_theme].nil?
  end


end # class

