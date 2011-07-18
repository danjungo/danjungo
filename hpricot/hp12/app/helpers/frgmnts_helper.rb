module FrgmntsHelper

  # Restrict the parents which appear in the pull-down-selector to the parents I own.
  def options_for_association_conditions(association)
    if association.name == :parent
      ['usr_id = ?', session[:usr_id]]
    else
      super
    end
  end

end
