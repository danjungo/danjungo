class Grp < ActiveRecord::Base
  has_and_belongs_to_many :frms
  has_and_belongs_to_many :gcategs
  belongs_to :usr
end
