module Asmy::UrllsHelper

  # Prepends a googlethis to values name column.
  def name_column(record)
    return "#{googlethis(record.name)} <a target='u2' href='#{record.name}' >#{record.name} </a> "
  end

  # Builds an a-element from record.pst
  def pst_column(record)
    ppst = record.pst
    lnk = link_to(h(ppst.name), :action => :show, :controller => 'psts', :id => ppst)
    return "#{googlethis(ppst.name)} #{lnk}"
  end

end

