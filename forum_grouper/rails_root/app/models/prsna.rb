class Prsna < ActiveRecord::Base
  has_and_belongs_to_many :frms
  belongs_to :usr
  has_many :psts
end
