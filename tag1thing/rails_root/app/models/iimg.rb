class Iimg < ActiveRecord::Base
  belongs_to :usr
  belongs_to :thng
  include ArBeforeSaveModule
end