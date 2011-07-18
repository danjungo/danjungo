class Asnp::FrmsController < ApplicationController

  # active_scaffold creates powerful JS based forms.  See http://activescaffold.com
  active_scaffold :frm do |config|
    config.label = "Forums"
    config.actions = [:list, :show, :search]
    config.columns[:grps].label = "Groups holding this Forum"
    config.columns[:name].label = "Name of this Forum"
    config.columns[:dsc].label = "Description of this Forum"
    config.columns[:uurl].label = "URL of this Forum"
    config.columns[:usr].label = "Owner"
    config.show.columns = [:grps, :name, :dsc, :usr, :uurl]
    config.list.columns = [:grps, :name, :dsc, :usr, :uurl]
  end

  # Only show frms owned by public
  def conditions_for_collection
    ['frms.prvt != ? AND grps.prvt != ? AND grps.usr_id != ?' , true, true, Usr.find_by_login("public").id]
  end
end
