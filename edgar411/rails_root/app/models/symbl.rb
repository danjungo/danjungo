class Symbl < ActiveRecord::Base

  validates_uniqueness_of :name, :message => " is already being used"
  # Associations should come after callbacks
  belongs_to :usr
  has_many :rpts

  protected

  def validate
    case
    # The controller will set name = "record_usr_id_ne_session_usr_id" if
    # I try to update a record I do not own.
    when name == "record_usr_id_ne_session_usr_id"
      errors.add_to_base "You can only update your records, not other's records."
    end # case
  end # validate
end # class


