module Asls::RptsHelper
  def name_column(record)
    return "#{googlethis(record.name)} #{record.name}"
  end # name_column
end
