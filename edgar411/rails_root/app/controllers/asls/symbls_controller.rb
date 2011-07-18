# Provides read-only view via active_scaffold
class Asls::SymblsController < ApplicationController

  skip_before_filter :authenticate_usr

  active_scaffold do |config|
    config.actions = [:list, :show, :search]
    config.label = "Stock Symbols"
    config.list.columns = [:usr, :name, :cname, :rpts]
    config.show.columns = [:usr, :name, :cname, :rpts]
    config.columns[:usr].label = "Owner Of This Symbol Name"
    config.columns[:name].label = "Symbol Name"
    config.columns[:cname].label = "Corporate Name"
    config.columns[:rpts].label = "Reports Available From EDGAR"
  end # active_scaffold block
end
