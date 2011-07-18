class Ashp::SymblsController < ApplicationController
  active_scaffold do |config|
    config.label = "Stock Symbols"
    config.list.columns = [:usr, :name, :cname, :rpts]
    config.show.columns = [:usr, :name, :cname, :rpts]
    config.create.columns = [:name, :cname]
    config.update.columns = [:name, :cname]
    config.columns[:usr].label = "Owner Of This Symbol Name"
    config.columns[:name].label = "Symbol Name"
    config.columns[:cname].label = "Corporate Name"
    config.columns[:rpts].label = "Reports Available From EDGAR"
  end # active_scaffold block

  # Before I save a new creation, fill-in some data
  def before_create_save(record)
    record.usr_id = session[:usr_id]
  end

  # Before I save a new update, fill-in some data
  def before_update_save(record)
    if (record.usr_id != session[:usr_id])
      # Force the call of a validation method.
      record.name = "record_usr_id_ne_session_usr_id"
    end
  end

end
