module Asmy::GrpsHelper

  # Restrict the gcategs which appear in the check boxes to the ones I own.
  def options_for_association_conditions(association)
    if association.name == :gcategs
      # join with public if session is missing the usr_id
      ['gcategs.usr_id = ?', (session[:usr_id] || Usr.find_by_login('public').id)]
    else
      super
    end
  end
end

