# Provides read-only view via active_scaffold
class Asls::RptsController < ApplicationController

  skip_before_filter :authenticate_usr

  active_scaffold do |config|
    config.actions = [:list, :show, :search]
    config.label = "EDGAR Input Reports"
    config.list.columns = [:usr, :symbl, :name, :uurl]
    config.show.columns = [:usr, :symbl, :name, :uurl]
    config.columns[:usr].label = "Owner Of This Report"
    config.columns[:symbl].label = "Symbol"
    config.columns[:name].label = "EDGAR Report Name"
    config.columns[:uurl].label = "EDGAR Report URL"
  end # active_scaffold block

end
