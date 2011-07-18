class Bcrmb < ActiveRecord::Base

  validates_uniqueness_of :name, :message => " is already being used"
  validates_uniqueness_of :bckey, :message => " is already being used"
  # Associations should come after callbacks
  belongs_to :usr

end
