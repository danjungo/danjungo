class Asmy::GrpsController < ApplicationController

  # Repel the guest.  We dont want guests to come here and create rows in the DB.
  before_filter :repel_usr_guest
  # Repel them if they manually edit the id in request URL
  before_filter :repel_them

  # active_scaffold creates powerful JS based forms.  See http://activescaffold.com
  active_scaffold do |config|
    config.label = "My Groups of Forums"
    config.list.columns = [:gcategs, :name, :dsc, :usr, :prvt, :uurl, :frms]
    config.show.columns = [:gcategs, :name, :dsc, :usr, :prvt, :uurl, :frms]
    config.create.columns = [:gcategs, :name, :dsc, :prvt ]
    config.update.columns = [:gcategs, :name, :dsc, :prvt ]
    config.columns[:gcategs].label = "This Group Appears In These Categories"
    config.columns[:name].label = "Group Name"
    config.columns[:dsc].label = "Group Description"
    config.columns[:usr].label = "Owner"
    config.columns[:prvt].label = "Private?"
    config.columns[:uurl].label = "URL"
    config.columns[:frms].label = "Forums in this Group"
    columns[:gcategs].form_ui = :select
  end

  protected

  # During creation of a new record, I want Rails to fill in usr_id and uurl with generated values.
  def before_create_save(record)
    record.usr_id = session[:usr_id]
  end

  # During creation of a new record, I want Rails to fill in usr_id and uurl with generated values.
  def after_create_save(record)
    if (record.uurl != "/asnp/grps/show/#{record.id}")
      record.uurl = "/asnp/grps/show/#{record.id}"
      record.save!
    end
  end

  # I only want groups owned by the usr_id in this session.
  def conditions_for_collection
    ['grps.usr_id = ?', [session[:usr_id]]]
  end
end
