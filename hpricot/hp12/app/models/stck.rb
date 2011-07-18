class Stck < ActiveRecord::Base

  # Associations should come after callbacks
  has_many :frgmnts
  # Validations come after associations
  validates_presence_of :name
  validates_uniqueness_of :name, :message => " is already being used.  Pick a different name."
end
