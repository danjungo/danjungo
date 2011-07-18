module Asls::SymblsHelper

  def name_column(record)
    return "#{googlethis(record.name)} #{record.name}"
  end # name_column

  def cname_column(record)
    return "#{googlethis(record.cname)} #{record.cname}"
  end # cname_column

end # module

