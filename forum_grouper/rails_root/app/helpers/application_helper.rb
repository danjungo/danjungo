# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper

  # An Hpricot based breadcrumb helper.
  # Usage:
  # bcrmb("<a href='/x/y'>About</a> | <a href='/z'>Contact</a>")
  # Loads html into an hpricot and then swaps out any a-tag with a span-tag
  # if the a-tag-href matches the request.path
  def bcrmb(h)
    # get an hpricot from the input-html
    hp =  Hpricot(h)
    # Inside the hpricot, look for an a-tag containing the request.path
    hps = hp.search("a[@href=#{request.path}]")
    if (matched_a_tag = hps.first)
      # I hooked one, get it's text node
      txtnode = matched_a_tag.inner_text
      # Inside the hpricot, swap the a-tag with a span-tag
      matched_a_tag.swap("<span class='bcrmb'>#{txtnode}</span>")
    end
    # Pull html out of the hpricot.
    return hp.to_html
  end # bcrmb


  # Builds a Google CSE URL from a string
  def googlethis(s)
    # Use url_for to help prep params for the google <a> tag
    p1 = url_for( {'q' => s, 'cx' => '010334745099783175565:l4tpxitiu7s', 'cof' => 'FORID:0', :controller => "jjnnkk", :trailing_slash => false} )
    p1 = url_for( {'q' => s, :controller => "jjnnkk", :trailing_slash => false} )
    # But wait, url_for puts tokens in there I dont want.
    # So, I use a jjnnkk controller to help me corral them.  I will then clobber them with a .sub()
    p2 = p1.sub(/^.*jjnnkk/,'')
    s3 = "<a target='git' href='http://google.com/search#{p2}'>"
    s5 = "Google-This: </a>"
    return "#{s3}#{s5}"
  end

  # Builds a simple a-tag from a string.  String assumed to be like http://ibm.com
  def uurl_column(record)
    s1 = "<a target='uurl'  href='#{record.uurl}'>#{record.uurl}</a>"
    # google this only for forums URLs return "#{googlethis(record.uurl)} #{s1}"
    s1
  end

  # Prepends a googlethis to values name column.
  def name_column(record)
    return "#{googlethis(record.name)} #{record.name}"
  end

  # Builds a ul-element from a collection of record.frms
  def frms_column(record)
    strng = ""
    record.frms.each {|e| strng << "<li /> #{link_to(h(e.name), :action => :show, :controller => 'frms', :id => e)}" }
    return "<ul> #{strng} </ul>"
  end

  # Builds a ul-element from a collection of record.grps
  def grps_column(record)
    strng = ""
    record.grps.each {|e| strng << "<li /> #{link_to(h(e.name), :action => :show, :controller => 'grps', :id => e)}" }
    return "<ul> #{strng} </ul>"
  end

  # Builds a ul-element from a collection of record.gcategs
  def gcategs_column(record)
    strng = ""
    record.gcategs.each {|e| strng << "<li /> #{link_to(h(e.name), :action => :show, :controller => 'gcategs', :id => e)}" }
    return "<ul> #{strng} </ul>"
  end

  # Builds a ul-element from a collection of record.urlls
  def urlls_column(record)
    strng = ""
    record.urlls.each {|e| strng << "<li /><a target='u1' href='#{h(e.name)}' > #{h(e.name)} </a>" }
    return "<ul> #{strng} </ul>"
  end

  # Gives a friendly view of Usr
#   def usr_column(record)
#     u = record.usr
#     "#{u.login} (email: #{u.email})"
#   end

end
