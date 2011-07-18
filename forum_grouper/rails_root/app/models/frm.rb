class Frm < ActiveRecord::Base
  has_and_belongs_to_many :grps
  has_and_belongs_to_many :prsnas
  has_and_belongs_to_many :psts
  belongs_to :usr
end
