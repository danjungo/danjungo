class Asmy::PstsController < ApplicationController

  # Repel the guest.  We dont want guests to come here and create rows in the DB.
  before_filter :repel_usr_guest
  # Repel them if they manually edit the id in request URL
  before_filter :repel_them

  # active_scaffold creates powerful JS based forms.  See http://activescaffold.com
  active_scaffold do |config|
    config.label = "My Posts"
    config.list.columns   = [:name, :prsna, :frms, :urlls]
    config.show.columns   = [:name, :prsna, :frms, :urlls]
    config.create.columns = [:name, :prsna, :frms, :urlls]
    config.update.columns = [:name, :prsna, :frms, :urlls]
    config.columns[:name].label  = "Name of Post"
    config.columns[:prsna].label = "Persona Who Wrote The Post"
    config.columns[:frms].label  = "Cross-Posted This Post To These Forums"
    config.columns[:urlls].label = "URLs Of This Post"
    columns[:frms].form_ui = :select
    columns[:prsna].form_ui = :select
  end

  protected

  # During creation of a new record, I want Rails to fill in usr_id, prsna_id
  def before_create_save(record)
    record.usr_id = session[:usr_id]
#    (record.prsna_id = Prsna.find_by_name("ForumGrouper").id) if record.prsna_id == nil
    (record.prsna_id = 1) if (record.prsna_id == nil)
  end

  # I only want psts owned by the usr_id in this session.
  def conditions_for_collection
    ['psts.usr_id = ?', [session[:usr_id]]]
  end
end
