class Tag < ActiveRecord::Base
  belongs_to :usr
  belongs_to :thng
  include ArBeforeSaveModule

  cattr_reader :per_page
  @@per_page = 9

end
