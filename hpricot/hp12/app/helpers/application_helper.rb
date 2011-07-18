# Methods in this helper are available to all templates in the application.
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


  # Builds a simple a-element from URL
  def inputurl_column(record)
    "<a target='inputurl'  href='#{record.inputurl}'>#{record.inputurl}</a>"
  end # inputurl_column

  # Override the stck column so I can add color to it via CSS
  def stck_column(record)
    "<span class='#{record.stck.name}'>#{record.stck.name}</span>"
  end

  # Override the frgtxt column so I can add links to it and maybe show a subset of the data in it.
  def frgtxt_column(record)
    link_to_rndr = link_to("Render The HTML Below:", {:id => record, :action => "rndr_frgmnt", :controller => "frgmnts"}, {:target => "l"})
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

  # I found this in the AS demo.  They use it to show ruby code which corresponds to scaffold views.
  # This helper is called in a partial here: app/views/layouts/_show_source.rhtml
  # Here is a sample line from app/views/layouts/_show_source.rhtml:
  # <%= show_code("controllers", "#{params[:controller]}_controller.rb") -%>
  def show_code(path, filename, comment = "")
    begin
      file = File.open("#{File.dirname __FILE__}/../../app/#{path}/#{filename}")
<<PRE_BLOCK
<h4>/#{path}/#{filename} #{comment}</h4>
<pre><code class=\"ruby\">#{file.read.gsub("<", "&lt;").gsub(">", "&gt;").strip}</code></pre>
PRE_BLOCK
    rescue
      "#{filename} is missing"
    end # begin, rescue
  end # show_code

end
