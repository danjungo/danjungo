class Gcateg < ActiveRecord::Base
  has_and_belongs_to_many :grps
  belongs_to :usr
end
