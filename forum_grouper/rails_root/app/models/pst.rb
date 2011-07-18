class Pst < ActiveRecord::Base
  has_and_belongs_to_many :frms
  belongs_to :usr
  belongs_to :prsna
  has_many :urlls
end
