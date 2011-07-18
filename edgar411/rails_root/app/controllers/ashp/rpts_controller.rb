class Ashp::RptsController < ApplicationController
  active_scaffold do |config|
    config.label = "EDGAR Input Reports"
    config.list.columns = [:usr, :symbl, :enddate, :rpttype, :name, :uurl]
    config.show.columns = [:usr, :symbl, :enddate, :rpttype, :name, :uurl]
    config.create.columns = [:symbl, :enddate, :rpttype, :uurl]
    config.update.columns = [:symbl, :enddate, :rpttype, :uurl]
    config.columns[:usr].label = "Owner Of This Report"
    config.columns[:symbl].label = "Symbol"
    config.columns[:enddate].label = "Period End Date"
    config.columns[:rpttype].label = "Report Type"
    config.columns[:name].label = "EDGAR Report Name"
    config.columns[:uurl].label = "EDGAR Report URL"
    columns[:symbl].form_ui = :select
    columns[:rpttype].form_ui = :select
  end # active_scaffold block


  # Before I save a new creation, fill-in some data
  def before_create_save(record)
    record.usr_id = session[:usr_id]
    # I derive the name of the object to prevent user from naming it stupidly
    record.name = "#{record.symbl.name}-#{record.rpttype.name}-#{record.enddate.to_s}"
  end

  # Before I save a new update, fill-in some data
  def before_update_save(record)
    if (record.usr_id != session[:usr_id])
      # Force the call of a validation method.
      record.name = "record_usr_id_ne_session_usr_id"
    end
    # I derive the name of the object to prevent user from naming it stupidly
    record.name = "#{record.symbl.name}-#{record.rpttype.name}-#{record.enddate.to_s}"
  end # before_update_save()

end # class
