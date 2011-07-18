class Thng < ActiveRecord::Base
  belongs_to :usr
  has_many :cmmnts
  has_many :iimgs
  has_many :videos
  has_many :tags
  has_many :uurls

  cattr_reader :per_page
  @@per_page = 9

  def before_save
    # Remove script-elements from HTML in thngdsc
    doc= Hpricot(self.thngdsc)
    doc.search("script").remove
    doc.search("*").each{|e|
      if e.comment?
        lst= e.parent.children
        e.parent= nil
        lst.delete(e)
      end
    }
    self.thngdsc= doc.to_html

    # Deal with dups headed for shrturl.
    # While @athng is found,
    # Change the shrturl unless I own the dup.
    if (@athng= Thng.find_by_shrturl(self.shrturl))
      self.shrturl= "#{self.shrturl}#{rand.to_s[2..5]}" unless @athng.usr== self.usr
    end

  end

end
