# A Frgmnt is a fragment of HTML scraped from another fragment (a parent) or a URL.
class Frgmnt < ActiveRecord::Base
  acts_as_tree  :order => "name"
  belongs_to :rpt
  belongs_to :outputrpt
  belongs_to :exprtype
  belongs_to :usr

  # Validations come after associations
  validates_presence_of :name, :outputrpt, :exprtype
  validates_uniqueness_of :name, :message => " is already being used.  Pick a different name for the fragment."

  protected

  def validate
    case
    # Ensure we have some input
    when (parent == nil and rpt == nil and inputurl == nil)
      errors.add(:parent, ", Input Report, and Input URL are all nil.  You need one.")
    # We only want 1 input
    when (parent != nil and rpt != nil)
      errors.add(:parent, "and Input Report are both not nil.  A fragment needs 1 (and only 1!) source (usually a parent)")
    # We only want 1 input
    when (parent != nil and inputurl != nil)
      errors.add(:parent, "and Input URL are both not nil.  A fragment needs 1 (and only 1!) source (usually a parent)")
    # We only want 1 input
    when (rpt != nil and inputurl != nil)
      errors.add(:rpt, "and Input URL are both not nil.  A fragment needs 1 (and only 1!) source (usually a parent)")
    # If a parent has no HTML, why scrape no-HTML?
    when (parent != nil and parent.frgtxt == nil)
      errors.add(:parent, " of this Fragment contains no HTML.  Maybe you picked the wrong parent")
    # We should not scrape ourself
    when (parent == self)
      errors.add(:parent, " == self.  Pick a different parent.")
    when (parent == nil and ['string-sandwich', 'gsub', 'sub', 'regexp-enumerable'].include?(exprtype.name))
    # When we scrape something off the net, only use hpricot
      errors.add(:exprtype, " Problem. Use hpricot type of scrape expression when using Input Report or Input URL.")
    # Use regexp to ensure that scrapeexpr starts with double quotes when exprtype is string-sandwich
    when (exprtype.name == 'string-sandwich' and ((scrapeexpr =~ /(^")/) != 0))
      errors.add(:scrapeexpr, " Problem.  string-sandwich Needs To Start With Double Quotes.")
    # Use regexp to ensure that scrapeexpr is formatted correctly for exprtype of "sub"
    when (exprtype.name == 'sub' and ((scrapeexpr =~ /^sub\(\/.*\)$/) != 0))
      errors.add(:scrapeexpr, " Problem. Maybe sub spelled wrong?  Demo: sub(/changeme/,'to this')")
    # Use regexp to ensure that scrapeexpr is formatted correctly for exprtype of "gsub"
    when (exprtype.name == 'gsub' and ((scrapeexpr =~ /^gsub\(\/.*\)$/) != 0))
      errors.add(:scrapeexpr, " Problem. Maybe gsub spelled wrong?  Demo: gsub(/changeme/,'to this')")
    # Branch on regexp
    when (exprtype.name == 'regexp-enumerable' and ((scrapeexpr =~ /^\/.*?\/$/) != 0))
      errors.add(:scrapeexpr, ' Problem. A regular expression looks something like this: /^(abc)(xyz)(123)$/')
    # hpricot-enumerable needs format like this: table.some-class,[1,5]
    when (exprtype.name == 'hpricot-enumerable' and  ((scrapeexpr =~ /(.*)?(\,)(\[)(\d+)(,)(\d+)(\])$/) != 0))
      errors.add(:scrapeexpr, ' Problem. hpricot-enumerable needs format like this: table.some-class,[1,5]')
    # The controller will set name = "record_usr_id_ne_session_usr_id" if
    # I try to update a record I do not own.
    when name == "record_usr_id_ne_session_usr_id"
      errors.add_to_base "You can only update your records, not other's records."
    # Use AR to validate that a glue fragment name is valid
    when exprtype.name == 'glue-fragment-to-parent'
      errors.add(:scrapeexpr, ' Problem:  Invalid fragment name.  Pick a fragment which actually exists.') if (Frgmnt.find_by_name(scrapeexpr) == nil)
    # Ensure that if I want to peel-off-outer-tag, I am doing it to a parent.
    when ((exprtype.name == 'peel-off-outer-tag') and  (parent == nil))
      errors.add(:parent, ' Problem: You can only peel-off-outer-tag of a parent')
    end # case
  end # validate

end   # class
