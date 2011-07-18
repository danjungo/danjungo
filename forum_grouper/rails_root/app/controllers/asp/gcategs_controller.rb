class Asp::GcategsController < ApplicationController
  # active_scaffold creates powerful JS based forms.  See http://activescaffold.com
  active_scaffold do |config|
    config.label = "Categories of Groups of Forums"
    config.actions = [:list, :show, :search]
    config.columns[:name].label = "Category Name"
    config.columns[:dsc].label = "Category Description"
    config.columns[:uurl].label = "Category URL"
    config.columns[:usr].label = "Owner"
    config.columns[:grps].label = "Groups in this Category"
    config.list.columns = [:name, :dsc, :usr, :uurl, :grps]
    config.show.columns = [:name, :dsc, :usr, :uurl, :grps]
  end

  # Only show gcategs owned by public
  def conditions_for_collection
    ['gcategs.usr_id = ?', Usr.find_by_login('public').id]
  end

end
