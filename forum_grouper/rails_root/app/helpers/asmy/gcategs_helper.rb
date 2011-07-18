module Asmy::GcategsHelper

  # Restrict the grps which appear in the check boxes to the ones I own.
  def options_for_association_conditions(association)
    if association.name == :grps
      # join with public if session is missing the usr_id
      ['grps.usr_id = ?', (session[:usr_id] || Usr.find_by_login('public').id)]
    else
      super
    end
  end
end
