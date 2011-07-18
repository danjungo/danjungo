class Asmy::UrllsController < ApplicationController

  # Repel the guest.  We dont want guests to come here and create rows in the DB.
  before_filter :repel_usr_guest
  # Repel them if they manually edit the id in request URL
# bug: Urll does not belong to usr  before_filter :repel_them

  # active_scaffold creates powerful JS based forms.  See http://activescaffold.com
  active_scaffold do |config|
    config.label = "URLs Of My Posts"
    config.list.columns   = [:name, :pst]
    config.show.columns   = [:name, :pst]
    config.create.columns = [:name, :pst]
    config.update.columns = [:name, :pst]
    config.columns[:name].label  = "URL"
    config.columns[:pst].label = "Subject or Name of Post"
  end

  protected

  # I only want psts owned by the usr_id in this session.
  def conditions_for_collection
    ['psts.usr_id = ?', [session[:usr_id]]]
  end
end
