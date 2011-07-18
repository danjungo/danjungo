module Ashp::FrgmntsHelper

  def name_form_column(record, input_name)
    # patterned off demo here: http://www.activescaffold.com/docs/form-overrides
    # It's confusing because :name appears twice.
    text_field(:record, :name, :name => input_name, :size => 20, :value => (record.name))
  end

  def scrapeexpr_form_column(record, input_name)
    text_area(:record, :scrapeexpr, :name => input_name, :rows => "44", :cols => "77")
  end


end # module
