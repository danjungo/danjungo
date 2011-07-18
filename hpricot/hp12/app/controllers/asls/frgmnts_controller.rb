class Asls::FrgmntsController < ApplicationController
  skip_before_filter :authenticate_usr
  # active_scaffold creates powerful JS based forms.  See http://activescaffold.com
  active_scaffold do |config|
    config.actions = [:list, :show]
    config.label = "Hpricot Workbench For Building Fragments Of HTML (Read-Only View)"
    config.list.columns = [:usr, :stck, :name, :inputurl, :parent, :exprtype, :arg1, :arg2, :arg3, :arg4, :frgtxt]
    config.show.columns = [:usr, :stck, :name, :inputurl, :parent, :exprtype, :arg1, :arg2, :arg3, :arg4, :frgtxt]

    config.columns[:usr].label = "Fragment Owner"
    config.columns[:stck].label = "Stack Name"
    config.columns[:name].label = "Fragment Name"
    config.columns[:parent].label = "Parent Fragment"
    config.columns[:inputurl].label = "Input URL"
    config.columns[:frgtxt].label = "Fragment Text Scraped From Input Source (Parent, or Input URL)"
    config.columns[:exprtype].label = "Type Of Expression"
  end # active_scaffold

  # Only show frgmnts owned by bikle or the usr (but no one else) in the current session
  def conditions_for_collection
    bikle_usr = Usr.find_by_login("bikle")
    (bikle_usr.nil?) ? (bikle_id = session[:usr_id]) : (bikle_id = bikle_usr.id)
    ['frgmnts.usr_id in (?,?)', bikle_id, [session[:usr_id]]]
    # Above statement generates SQL like this:
    # SELECT * FROM frgmnts WHERE  frgmnts.usr_id in (1, 43)
  end

end
