#!/usr/bin/env ruby

# mech/availability.rb

# gets availability console portion of em

require 'rubygems'
require 'mechanize'
require 'hpricot'

Hpricot.buffer_size = 321123
# Default html_parser is nokogiri but it is bumping into a bug on Linux due to old version of libxml2.
WWW::Mechanize.html_parser = Hpricot 
aagent = WWW::Mechanize.new { |agent|
  agent.user_agent_alias = 'Mac FireFox'
}
aagent.get('https://z:1158/em/console/logon/logon') do |page|
  home_page = page.form_with(:name => 'User') do |login|
    login.userName = "trade"
    login.userPassword = "t"
  end.submit
  av_page = aagent.get('https://z:1158/em/console/database/haConsole?event=doLoad&target=orcl5.moi&type=oracle_database')
  # I like Hpricot so I move the data into an Hpricot object named @doc.
  @doc = Hpricot(av_page.body.to_s.
    gsub(/<a /,'<span ').
    gsub(/\/a>/,'/span>')
  )
  # Remove all useless elements and attributes from @doc before I work with it.
  (@doc/"td").remove_attr("align")
  (@doc/"span.x8[text()='MAA Advisor']/../..").remove
  # Get the 'Page Refresh' time now message
  av_time_now_html = "<span class='title10'>EM Captured: </span>"
  av_time_now_html << (@doc/"label.x8h[text()*='Page Refreshed']/.. span.x8g[text()*='0']").to_html
  # Get the name of the DB Instance
  av_db_inst_html = (@doc/"span.x6r[text()*='Database Instance : ']").to_html
  # Get tr-elems of the 1st table I want
  av_tr_html = (@doc/"table span.x8[text()='Status']/../../.. tr").to_html
  av_table_html = "<table>#{av_tr_html}</table>"

  # Get Flash Recovery Area Info
  # Get the FRA-Chart
  mysrc = (@doc/"img[@alt='Chart']").first.get_attribute("src")
  aagent.get("https://z:1158#{mysrc}").save("../public/s/availability/fra_chart.gif")
  # replace em chart with local chart
  (@doc/"img[@alt='Chart']").first.swap("<img alt='fra_chart.gif' src='fra_chart.gif' />")
  # Get the FRA legend gifs
  (@doc/"img[@src*='em/images/chartCache/chip_java.awt.Color']").each { |dc|
    fname = dc.get_attribute("src")
    mysrc = fname.sub(/\[/,'%5B').sub(/\]/,'%5D')
    aagent.get("https://z:1158#{mysrc}").save("../public/s/availability/.#{fname}")
  }
  # Get the table.  Add '/s/availability' to the src attributes
  av_fra_table_html = (@doc/"span.x8[text()='Flash Recovery Area']/../../../../../..").
    to_html.
    gsub(/\/em\/images\/chartCache/,'/s/availability/em/images/chartCache')
  # Stuff it all into an li-element
  av_html_wrapped = "<li class='home_html'>"
    av_html_wrapped << "<hr />"
    av_html_wrapped << "Availability"
    av_html_wrapped << "<hr />"
    av_html_wrapped << av_time_now_html
    av_html_wrapped << "<hr />"
    av_html_wrapped << av_db_inst_html
    av_html_wrapped << "<hr />"
    av_html_wrapped << av_table_html
    av_html_wrapped << "<hr />"
    av_html_wrapped << av_fra_table_html
    av_html_wrapped << "<hr />"
  av_html_wrapped << "</li>"
  # Get a copy of the public/index.html,
  # I want to use it as a layout.
  @docidx = open("../public/index.html"){ |f| Hpricot(f) }
  # Mix-in av_html_wrapped at the top of the ul-element.
  (@docidx/"ul#home").prepend(av_html_wrapped)
  # Consider this page to be on_web rather than in_phone.
  @docidx.at(:body).set_attribute("class","on_web")
  # Remove the Site Home label from /index.html
  (@docidx/"li#site_home").remove
  av_html_wrapped = @docidx.to_html
  # Now make it public.
  fhw = File.open("../public/s/availability/index.html","w")
  fhw.write(av_html_wrapped)
  fhw.close
end # aagent.get


