# Used to control Active Scaffold UI for Frm model
class Asmy::FrmsController < ApplicationController

  # Repel the guest.  We dont want guests to come here and create rows in the DB.
  before_filter :repel_usr_guest
  # Repel them if they manually edit the id in request URL
  before_filter :repel_them

  # active_scaffold creates powerful JS based forms.  See http://activescaffold.com
  active_scaffold do |config|
    config.label = "My Forums"
    config.list.columns = [:grps, :name, :dsc, :usr, :prvt, :uurl]
    config.show.columns = [:grps, :name, :dsc, :usr, :prvt, :uurl]
    config.create.columns = [:grps, :name, :dsc, :prvt, :uurl]
    config.update.columns = [:grps, :name, :dsc, :prvt, :uurl]
    config.columns[:grps].label = "This Forum Appears In These Groups"
    config.columns[:name].label = "Forum Name"
    config.columns[:dsc].label = "Forum Description"
    config.columns[:usr].label = "Owner"
    config.columns[:prvt].label = "Private?"
    config.columns[:uurl].label = "URL"
    columns[:grps].form_ui = :select
  end

  protected

  # Before I save a new creation, fill-in the usr_id.
  def before_create_save(record)
    record.usr_id = session[:usr_id]
  end

  # Only show frms owned by the usr in the current session
  def conditions_for_collection
    ['frms.usr_id = ?', [session[:usr_id]]]
  end

end
