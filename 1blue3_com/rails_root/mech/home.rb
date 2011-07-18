#!/usr/bin/env ruby

# mech/home.rb

# gets home portion of em

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
  # I like Hpricot so I move the data into an Hpricot object named doc.
  doc = Hpricot(home_page.body.to_s.
    gsub(/<a /,'<span ').
    gsub(/\/a>/,'/span>')
  )
  # Remove all useless elements from the page before I work with it.
  (doc/"span[@href*='/em/console/database/config']").remove
  (doc/"span[text()='Last Known State']").remove
  (doc/"span[text()='View All Properties']").remove
  (doc/"span[text()='Database Instance Health']").remove
  # Get the 'Page Refresh' time now message
  home_now_html = "<span class='title10'>EM Captured: </span>"
  home_now_html << (doc/"span[text()*='Page Refreshed']/.. span.x58").to_html
  # Get the arrow (or whatever status indicator is there).
  sel_up = "img[@src*='40up.gif']" # This is the up-green-arrow
  sel_down = "img[@src*='40down.gif']" # This is the down-red-arrow
  sel_err = "img[@src*='40errorinmetric.gif']" # This is the blue-wave-red-x
  sel_inprog = "img[@src*='40inprogress.gif']" # This is the blue-clock
  case
  when (doc/sel_up).size == 1
    home_arrow_img = "<img src='/s/home/40up.gif' />"
  when (doc/sel_down).size == 1
    home_arrow_img = "<img src='/s/home/40down.gif' />"
  when (doc/sel_err).size == 1
    home_arrow_img = "<img src='/s/home/40errorinmetric.gif' />"
  when (doc/sel_inprog).size == 1
    home_arrow_img = "<img src='/s/home/40inprogress.gif' />"
  end
  # This should select tr-elems of table below the arrow.
  home_arrow_tr_html = (doc/"table span.x8[text()='Status']/../../.. tr").to_html
  home_arrow_table_html = "<table>#{home_arrow_tr_html}</table>"
  home_arrow_html = "<span class='title10'>General</span><br />#{home_arrow_img}<br />#{home_arrow_table_html}"
  # Host Cpu gifs
  src_hcpu = (doc/"img[@alt*='Host CPU']").first.get_attribute("src")
  aagent.get("https://z:1158#{src_hcpu}").save("../public/s/home/hcpu.gif")
  hcpu_img = "<img src='/s/home/hcpu.gif' />"
  # get legend for host cpu gif
  # Non-instance CPU usage
  doc_hcpu_legend1 = (doc/"img[@title='Non-instance CPU usage']")
  src_hcpu_legend1 = doc_hcpu_legend1.first.get_attribute("src").sub(/\[/,'%5B').sub(/\]/,'%5D')
  aagent.get("https://z:1158#{src_hcpu_legend1}").save("../public/s/home/hcpu_legend1.gif")
  hcpu_legend1_img = "<img src='/s/home/hcpu_legend1.gif' width='20' height='12'/>: <span class='gif_legend'>Non-instance CPU usage</span>"
  # Instance CPU usage
  doc_hcpu_legend2 = (doc/"img[@title='Instance CPU usage']")
  src_hcpu_legend2 = doc_hcpu_legend2.first.get_attribute("src").sub(/\[/,'%5B').sub(/\]/,'%5D')
  aagent.get("https://z:1158#{src_hcpu_legend2}").save("../public/s/home/hcpu_legend2.gif")
  hcpu_legend2_img = "<img src='/s/home/hcpu_legend2.gif' width='20' height='12'/>: <span class='gif_legend'>Instance CPU usage</span>"
  hcpu_legend_img = "#{hcpu_legend1_img}<br />#{hcpu_legend2_img}"
  hcpu_html = "<span class='title10'>Host Cpu</span><br />#{hcpu_img}<br />#{hcpu_legend_img}"
  # Load
  home_load_html = "<br /><br />Avg # processes waiting to be scheduled:<br />"
  home_load_html << (doc/"span.xd[@title*='Average number of processes waiting to be scheduled']").first.to_html
  # Paging
  home_paging_html = "<br />Number of memory pages paged-out per second:<br />"
  home_paging_html << (doc/"span.xd[@title='Number of memory pages paged-out per second']").first.to_html
  # Active Sessions
  home_active_sessions_html = "<span class='title10'>Active Sessions</span>"
  src_as = (doc/"img[@alt='Chart Titled: Active Sessions']").first.get_attribute("src")
  aagent.get("https://z:1158#{src_as}").save("../public/s/home/as.gif")
  home_active_sessions_html << "<br /><img src='/s/home/as.gif' />"
  # AS Legend
  as_legend_html = "<br /><span class='title10'>Active Sessions Legend:</span> "
  gifn = 0
  (doc/"img[@title*='Average response time of the system']").each { |dc|
    myttl = dc.get_attribute("title")
    mysrc = dc.get_attribute("src").sub(/\[/,'%5B').sub(/\]/,'%5D')
    aagent.get("https://z:1158#{mysrc}").save("../public/s/home/as_legend#{gifn.to_s}.gif")
    as_legend_html << "<br /><img src='/s/home/as_legend#{gifn.to_s}.gif' width='20' height='12' />: "
    as_legend_html << "<span class='gif_legend'>#{myttl}</span>"
    gifn += 1
  }
  home_active_sessions_html << as_legend_html
  # Core Count
  cc_html = (doc/"span.x8[text()='Core Count']/../.. span").to_html.sub(/Count/,'Count:&nbsp;').sub(/x8/,'title10')
  home_active_sessions_html << "<br />#{cc_html}"
  # SQL Response Time
  home_sql_rt_html = "<span class='title10'>SQL Response Time</span>"
  src_sql_rt = (doc/"img[@alt='Chart Titled: SQL Response Time']").first.get_attribute("src")
  aagent.get("https://z:1158#{src_sql_rt}").save("../public/s/home/sql_rt.gif")
  home_sql_rt_html << "<br /><img src='/s/home/sql_rt.gif' />"
  # SQL Response Time Legend
  sql_rt_legend_html = "<span class='title10'>SQL Response Time Legend:</span> "
  gifn = 0
  (doc/"img[@title*='Collection (seconds)']").each { |dc|
    myttl = dc.get_attribute("title")
    mysrc = dc.get_attribute("src").sub(/\[/,'%5B').sub(/\]/,'%5D')
    aagent.get("https://z:1158#{mysrc}").save("../public/s/home/sql_rt_legend#{gifn.to_s}.gif")
    sql_rt_legend_html << "<br /><img src='/s/home/sql_rt_legend#{gifn.to_s}.gif' width='20' height='12' />: "
    sql_rt_legend_html << "<span class='gif_legend'>#{myttl}</span>"
    gifn += 1
  }
  # SQL Response Time (%)
  sql_rt_pct_html = "<span class='title10'>SQL Response Time (%): &nbsp; </span> "
  sql_rt_pct_html << (doc/"span[text()='SQL Response Time (%)']../.. span.xd").to_html
  home_sql_rt_html << "<br />#{sql_rt_legend_html}<br />#{sql_rt_pct_html}"
  # Diagnostic Summary
  home_diag_html = "<span class='title10'>Diagnostic Summary</span> <br />"
  home_diag_tr_html = (doc/"span.x8[text()='ADDM Findings']/../../.. tr").to_html
  home_diag_html << "<table>#{home_diag_tr_html}</table>"
  # Space Summary
  home_space_html = "<span class='title10'>Space Summary</span> <br />"
  home_space_tr_html = (doc/"span[text()='Segment Advisor Recommendations']/../../.. tr").to_html
  home_space_html << "<table>#{home_space_tr_html}</table>"

  # High Availability
  home_ha_html = "<span class='title10'>High Availability</span> <br />"
  (doc/"span.x8[text()='Console']/../..").remove
  home_ha_tr_html = (doc/"span[text()='Usable Flash Recovery Area (%)']/../../.. tr").to_html
  home_ha_html << "<table>#{home_ha_tr_html}</table>"

  fhw = File.open("../public/debug/index.html","w")
  fhw.write(home_ha_html)
  fhw.close

  # Construct HTML for home page.

  home_html = "<li class='home_html'>"
    home_html << "<hr />"
    home_html << "DB Home"
    home_html << "<hr />"
    home_html << home_now_html
    home_html << "<hr />"
    home_html << home_arrow_html
    home_html << "<hr />"
    home_html << hcpu_html
    home_html << home_load_html
    home_html << home_paging_html
    home_html << "<hr />"
    home_html << home_active_sessions_html
    home_html << "<hr />"
    home_html << home_sql_rt_html
    home_html << "<hr />"
    home_html << home_diag_html
    home_html << "<hr />"
    home_html << home_space_html
    home_html << "<hr />"
    home_html << home_ha_html
    home_html << "<hr />"
    home_html << "<hr />"
  home_html << "</li>"

  # Get a copy of the public/index.html,
  # I want to use it as a layout.
  docidx = open("../public/index.html"){ |f| Hpricot(f) }
  # remove the site_home label
  (docidx/"li#site_home").remove
  # Mix-in home_html at the top of the ul-element.
  (docidx/"ul#home").prepend(home_html)
  # Consider this page to be on_web rather than in_phone.
  docidx.at(:body).set_attribute("class","on_web")
  home_html_wrapped = docidx.to_html
  # Now make it public.
  fhw = File.open("../public/s/home/index.html","w")
  fhw.write(home_html_wrapped)
  fhw.close

end # aagent.get


