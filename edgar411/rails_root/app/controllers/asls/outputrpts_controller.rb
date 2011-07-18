# Provides read-only view via active_scaffold
class Asls::OutputrptsController < ApplicationController

  skip_before_filter :authenticate_usr

  active_scaffold do |config|
    config.actions = [:list, :show, :search]
    config.label = "Output Reports Built From Fragments Of EDGAR Reports"
    config.list.columns = [:usr, :rpt, :name, :frgmnts, :finalfrgmnt_name]
    config.show.columns = [:usr, :rpt, :name, :frgmnts, :finalfrgmnt_name]
    config.columns[:usr].label = "Owner of This Output Report"
    config.columns[:rpt].label = "EDGAR Report Providing Input Fragments"
    config.columns[:name].label = "Output Report Built From Fragments Coalesced Into Final Fragment"
    config.columns[:frgmnts].label = "Fragments of EDGAR Report"
    config.columns[:finalfrgmnt_name].label = "Name Of Final Fragment (Built From Coalesced Fragments)"
  end # active_scaffold
end
