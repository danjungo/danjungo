class Frgmnt < ActiveRecord::Base
  acts_as_tree  :order => "name"
  # Associations should come after callbacks
  belongs_to :usr
  belongs_to :exprtype
  belongs_to :stck
  # Validations come after associations
  validates_presence_of :name
  validates_uniqueness_of :name, :message => " is already being used.  Pick a different name."

  protected

  def validate
    case
    # Ensure we have some input
    when (parent == nil and inputurl == nil)
      errors.add(:parent, ", and Input URL are all nil.  You need one.")
    # We only want 1 input
    when (parent != nil and inputurl != nil)
      errors.add(:parent, "and Input URL are both not nil.  A fragment needs 1 (and only 1!)")
    # We should not scrape ourself
    when (parent == self)
      errors.add(:parent, " == self.  Pick a different parent.")
    # The controller will set name = "record_usr_id_ne_session_usr_id" if
    # I try to update a record I do not own.
    when name == "record_usr_id_ne_session_usr_id"
      errors.add_to_base "You can only update your records, not other's records."
    # display-enumerable needs format like this: table.some-class,[1,5]
    when (exprtype.name == 'display-enumerable()' and  ((arg1 =~ /(.*)?(\,)(\[)(\d+)(,)(\d+)(\])$/) != 0))
      errors.add(:arg1, ' Problem. display-enumerable() needs format like this: table.some-class,[1,5]')
    end # case
  end # validate

end
