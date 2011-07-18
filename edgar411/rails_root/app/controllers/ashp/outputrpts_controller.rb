class Ashp::OutputrptsController < ApplicationController
  active_scaffold do |config|
    config.label = "Output Reports Built From Fragments Of EDGAR Reports"
    config.list.columns = [:usr, :rpt, :outputrpttype, :name, :frgmnts, :finalfrgmnt_name]
    config.show.columns = [:usr, :rpt, :outputrpttype, :name, :frgmnts, :finalfrgmnt_name]
    config.create.columns = [:rpt, :outputrpttype, :finalfrgmnt_name]
    config.update.columns = [:rpt, :outputrpttype, :finalfrgmnt_name]
    config.columns[:usr].label = "Owner of This Output Report"
    config.columns[:rpt].label = "EDGAR Report Providing Input Fragments"
    config.columns[:outputrpttype].label = "Output Report Type"
    config.columns[:name].label = "Output Report Built From Fragments Coalesced Into Final Fragment"
    config.columns[:frgmnts].label = "Fragments of EDGAR Report"
    config.columns[:finalfrgmnt_name].label = "Name Of Final Fragment (Built From Coalesced Fragments)"
    columns[:rpt].form_ui = :select
    columns[:outputrpttype].form_ui = :select
  end # active_scaffold

  # Before I save a new creation, fill-in some data
  def before_create_save(record)
    record.usr_id = session[:usr_id]
    # I derive the name of the object to prevent user from naming it stupidly
    record.name = "#{record.rpt.name}-#{record.outputrpttype.name}"
  end

  # Before I save a new update, fill-in some data
  def before_update_save(record)
    if (record.usr_id != session[:usr_id])
      # Force the call of a validation method.
      record.name = "record_usr_id_ne_session_usr_id"
    end
    # I derive the name of the object to prevent user from naming it stupidly
    record.name = "#{record.rpt.name}-#{record.outputrpttype.name}"
  end # before_update_save()

end # class
