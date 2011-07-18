class Cmmnt < ActiveRecord::Base
  belongs_to :usr
  belongs_to :thng
  include ArBeforeSaveModule

end # class

