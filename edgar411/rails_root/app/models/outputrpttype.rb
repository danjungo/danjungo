class Outputrpttype < ActiveRecord::Base

  validates_uniqueness_of :name, :message => " is already being used"
  # Associations should come after callbacks
  belongs_to :usr
  has_many :outputrpts

end
