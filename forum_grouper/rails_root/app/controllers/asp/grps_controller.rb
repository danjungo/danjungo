class Asp::GrpsController < ApplicationController
  # active_scaffold creates powerful JS based forms.  See http://activescaffold.com
  active_scaffold do |config|
    config.label = "Groups of Forums"
    config.actions = [:list, :show, :search]
    config.columns[:gcategs].label = "This group belongs to these Categories"
    config.columns[:name].label = "Group Name"
    config.columns[:dsc].label = "Group Description"
    config.columns[:uurl].label = "Group URL"
    config.columns[:usr].label = "Owner"
    config.columns[:frms].label = "Forums in this group"
    config.list.columns = [:gcategs, :name, :dsc, :usr, :uurl, :frms]
    config.show.columns = [:gcategs, :name, :dsc, :usr, :uurl, :frms]
  end

  # Only show grps owned by public
  def conditions_for_collection
    ['grps.usr_id = ?', Usr.find_by_login('public').id]
  end

end
