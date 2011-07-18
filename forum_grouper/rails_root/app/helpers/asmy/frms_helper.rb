module Asmy::FrmsHelper

  # Builds a simple googlethis-a-tag from a string.  String assumed to be like http://ibm.com
  def uurl_column(record)
    s1 = "<a target='uurl'  href='#{record.uurl}'>#{record.uurl}</a>"
    return "#{googlethis(record.uurl)} #{s1}"
  end

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
