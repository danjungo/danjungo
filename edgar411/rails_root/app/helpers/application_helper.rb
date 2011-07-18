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
    p1 = url_for( {'q' => s, 'cx' => '013792173911716421330:ejhom2oemz4', 'cof' => 'FORID:0', :controller => "jjnnkk", :trailing_slash => false} )
    # But wait, url_for puts tokens in there I dont want.
    # So, I use a jjnnkk controller to help me corral them.  I will then clobber them with a .sub()
    p2 = p1.sub(/^.*jjnnkk/,'')
    s3 = "<a target='git' href='http://google.com/cse#{p2}'>"
    s5 = "Google-This: </a>"
    return "#{s3}#{s5}"
  end

  # Builds a simple googlethis-a-tag from a string.  String assumed to be like http://ibm.com
  def uurl_column(record)
    s1 = "<a target='uurl'  href='#{record.uurl}'>#{record.uurl}</a>"
    return "#{googlethis(record.uurl)} #{s1}"
  end

  # Builds a ul-element from a collection of record.rpts
  def rpts_column(record)
    strng = ""
    record.rpts.each {|e| strng << "<li /> #{link_to(h(e.name), :action => :show, :controller => 'rpts', :id => e)}" }
    return "<ul> #{strng} </ul>"
  end

  # Builds a ul-element from a collection of record.frgmnts
  def frgmnts_column(record)
    strng_a = []
    record.frgmnts.each do |frg|
      link1 = link_to("Render", {:id => frg, :action => "rndr_frgmnt", :controller => "frgmnts"}, {:target => "l"})
      link2 = link_to("#{frg.name}", {:id => frg, :action => "show", :controller => "frgmnts"}, {:target => "l"})
      strng_a << "<li />#{link1} or show #{link2}"
    end # record.frgmnts.each
    return "<ul> #{strng_a.sort.to_s} </ul>"
  end # frgmnts_column()

  # Enhances the rpt column appearing in outputrpts list and frgmnts list.
  # Override the rpt column so I can add links to it.
  def rpt_column(record)
    if record.rpt == nil
      return "nil"
    else
      link_to_rndr = "<a target='l' href='#{record.rpt.uurl}'>Link To EDGAR Input Report</a>"
      link_to_rpt =  link_to("Meta-Data of: #{record.rpt.name}", {:id => record.rpt, :action => "show", :controller => "asls/rpts"})
      return("<hr />#{link_to_rndr}<hr />#{link_to_rpt}<hr />")
    end # if
  end # rpt_column()

  # Override the frgtxt column so I can add links to it and maybe show a subset of the data in it.
  def frgtxt_column(record)
    link_to_rndr = link_to("Render The HTML Below:", {:id => record, :action => "rndr_frgmnt", :controller => "asls/frgmnts"}, {:target => "l"})
    # Use the ERB::Util.h() method below to make sure the HTML is displayed rather than rendered.
    # If they want to render, they can click the link.
    # Notice that I use .slice() to limit the amount of text sent back to the browser.
    # If they want to see all of the text they can .rndr_frgmnt() and use browser-view-source.
    myfrgtxt = (record.frgtxt || "nil")
    if (h(myfrgtxt).length > 1024)
      snipmsg = "<span class='snipmsg'>SNIPPED at character number 1024.  Use render and then browser-view-source to see all of it.</span>"
    else
      snipmsg = ""
    end # if
    return("<div class='frgmnt-frgtxt'> <hr />#{link_to_rndr}<hr />#{h(myfrgtxt.slice(0,1024))} <hr /> #{snipmsg} <hr /></div>")
  end # frgtxt_column()

  # Builds elements from a name of a finalfrgmnt.  Used to display final frgmnt in outputrpts.
  def finalfrgmnt_name_column(record)
    # Since I have an Outputrpt object in the record variable, I can get the finalfrgmnt_name name.
    # And with the name I can get the frgmnt.
    # Then build an a-tag using the ENTIRE frgmnt (frgmnt.id does not work for some reason).
    frgmnt_i_want = Frgmnt.find_by_name(record.finalfrgmnt_name)
    case
    when frgmnt_i_want == nil
      # Return only a string since a link would just point no where.
      return record.finalfrgmnt_name
    else
      # Ah, we have a valid frgmnt.  Go hog wild.  I will build a-tags.
        link1 = link_to("Render", {:id => frgmnt_i_want, :action => "rndr_frgmnt", :controller => "frgmnts"}, {:target => "l"})
        link2 = link_to("#{record.finalfrgmnt_name}", {:id => frgmnt_i_want, :action => "show", :controller => "frgmnts"}, {:target => "l"})
      return "#{link1} or show #{link2}"
    end # case
  end # finalfrgmnt_name_column()

  # I want the year in front.  It sorts better.  .to_s() does exactly what I want.
  def enddate_column(record)
    record.enddate.to_s
  end

  # I found this in the AS demo.  They use it to show ruby code which corresponds to scaffold views.
  # This helper is called in a partial here: app/views/layouts/_show_source.rhtml
  def show_code(path, filename, comment = "")
    begin
      file = File.open("#{File.dirname __FILE__}/../../app/#{path}/#{filename}")
<<PRE_BLOCK
<h4>/#{path}/#{filename} #{comment}</h4>
<pre><code class=\"ruby\">#{file.read.gsub("<", "&lt;").gsub(">", "&gt;").strip}</code></pre>
PRE_BLOCK
    rescue
      "#{filename} is missing"
    end
  end

end
