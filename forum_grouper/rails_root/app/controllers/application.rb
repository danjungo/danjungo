# A daddy controller.  Methods here are global to the children.

require 'usr_system'
require 'rubygems'
require 'hpricot'
require 'open-uri'

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_fg12_session_id'
  include ERB::Util
  include UsrSystem
  helper :usr
  # before_filter :authenticate_usr

  # Set the default page size for AS
  ActiveScaffold.set_defaults do |config|
    config.list.per_page = 199
  end

  # Maybe login as guest unless logged in already.
  def maybe_login_guest
    # Assume that guest exists in DB
    # session[:usr_id] = (Usr.find_by_login("guest").id)
    # Being a guest means that session[:usr_id] is nil
    # unless (session[:usr_id])
    # The idea that a guest has a usr_id causes problems with login_sugar.
    # So, a guest does not have a usr_id.
  end

  # A guest repellent to keep guest away from some controllers and/or actions
  def repel_usr_guest
    redirect_to("/") if session[:usr_id].nil?
  end

  # Repel users who manually tinker with id in the request URL
  def repel_them
    # I dont need to repel_them if id is nil
    return if (params[:id] == nil)

    # Get the model class loaded into an object which can also be a class
    myklass = self.active_scaffold_config.model
    # Use the object-class-beastie to run .find() against the id in the request URL
    the_obj = myklass.find(params[:id])
    # Find out who owns the_obj
    the_usr_id = the_obj.send(:usr_id)
    # Repel them if they dont own the object pointed to by the id in the request URL
    redirect_to("/") unless the_usr_id == session[:usr_id]
  end

end # class


