class Asmy::PrsnasController < ApplicationController

  # Repel the guest.  We dont want guests to come here and create rows in the DB.
  before_filter :repel_usr_guest
  # Repel them if they manually edit the id in request URL
  before_filter :repel_them

  # active_scaffold creates powerful JS based forms.  See http://activescaffold.com
  active_scaffold do |config|
    config.label = "My Personas"
    config.list.columns   = [:name, :eml, :psswd, :frms]
    config.show.columns   = [:name, :eml, :psswd, :frms]
    config.create.columns = [:name, :eml, :psswd, :frms]
    config.update.columns = [:name, :eml, :psswd, :frms]
    config.columns[:name].label  = "Persona Name"
    config.columns[:eml].label   = "Persona E-Mail Address"
    config.columns[:psswd].label = "Persona Password Mnemonic"
    config.columns[:frms].label  = "This Persona Is Used In These Forums"
    columns[:frms].form_ui = :select
  end

  protected

  # During creation of a new record, I want Rails to fill in usr_id
  def before_create_save(record)
    record.usr_id = session[:usr_id]
  end

  # I only want prsnas owned by the usr_id in this session.
  def conditions_for_collection
    ['prsnas.usr_id = ?', [session[:usr_id]]]
  end

end
