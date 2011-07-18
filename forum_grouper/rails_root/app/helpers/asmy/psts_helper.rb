module Asmy::PstsHelper

  # Builds an a-element from record.prsna
  def prsna_column(record)
    pprsna = record.prsna
    return if pprsna == nil
    lnk = link_to(h(pprsna.name), :action => :show, :controller => 'prsnas', :id => pprsna)
    return "#{googlethis(pprsna.name)} #{lnk}"
  end

  # Restrict the frms which appear in the check boxes to the ones I own.
  # Also restrict prsnas which appear in the pull-down.
  def options_for_association_conditions(association)
    case association.name
    when :frms
      # join with public if session is missing the usr_id
      ['frms.usr_id = ?', (session[:usr_id] || Usr.find_by_login('public').id)]
    when :prsna
      # join with public if session is missing the usr_id
      ['prsnas.usr_id = ?', (session[:usr_id] || Usr.find_by_login('public').id)]
    else
      super
    end
  end

end
