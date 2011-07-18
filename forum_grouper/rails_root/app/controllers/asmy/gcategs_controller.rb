# Controller for My Categories
class Asmy::GcategsController < ApplicationController

  # Repel the guest.  We dont want guests to come here and create rows in the DB.
  before_filter :repel_usr_guest

  # Repel them if they manually edit the id in request URL
  before_filter :repel_them

  # active_scaffold creates powerful JS based forms.  See http://activescaffold.com
  active_scaffold do |config|
    config.label = "My Categories Of Groups"
    config.list.columns = [:name, :dsc, :usr, :prvt, :uurl, :grps]
    config.show.columns = [:name, :dsc, :usr, :prvt, :uurl, :grps]
    config.create.columns = [:grps, :name, :dsc, :prvt]
    config.update.columns = [:grps, :name, :dsc, :prvt]
    config.columns[:name].label = "Category Name"
    config.columns[:dsc].label = "Category Description"
    config.columns[:usr].label = "Owner"
    config.columns[:prvt].label = "Private?"
    config.columns[:uurl].label = "URL"
    config.columns[:grps].label = "Groups in this Category"
    columns[:grps].form_ui = :select
  end

  protected
  # During creation of a new record, I want Rails to fill in usr_id and uurl with generated values.
  def before_create_save(record)
    record.usr_id = session[:usr_id]
  end

  # During creation of a new record, I want Rails to fill in usr_id and uurl with generated values.
  def after_create_save(record)
    if (record.uurl != "/asnp/gcategs/show/#{record.id}")
      record.uurl = "/asnp/gcategs/show/#{record.id}"
      record.save!
    end
  end

  def conditions_for_collection
    ['gcategs.usr_id = ?', [session[:usr_id]]]
  end

end
