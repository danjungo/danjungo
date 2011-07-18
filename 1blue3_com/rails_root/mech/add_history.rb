#!/usr/bin/env ruby

# mech/add_history.rb

# Edits public/history/index.html so it contains links to public/history/2*/index.html

require 'rubygems'
require 'mechanize'
require 'hpricot'

Hpricot.buffer_size = 321123

# Get the history_html from Dir listing of /public/history/2*/index.html
# 1st strip-off string: "../public/history/"
history_html_href_a = Dir["../public/history/2*/index.html"].map{|idx| idx.sub(/..\/public\/history\//,'')}
# Im left with href-attribute-values. Mix them with simple HTML elements.
history_html_a = history_html_href_a.map{ |h| "<li><a href='#{h}'>#{h.sub(/\/index.html/,'')}</a></li>"}

# Copy /public/history.html into @history_hpricot
@history_hpricot = open("../public/history.html"){ |f| Hpricot(f) }
# Mix-in history_html_a
(@history_hpricot/:ul).append(history_html_a.sort.reverse.to_s)

# Get a copy of the public/index.html,
# I want to use it as a layout.
@index_hpricot = open("../public/index.html"){ |f| Hpricot(f) }

# Remove ul-element from @index_hpricot
(@index_hpricot/"ul#home").remove

# Append @history_hpricot to body-element of @index_hpricot
(@index_hpricot/"body").append(@history_hpricot.to_html)

# Signal that this page is on the web
@index_hpricot.at(:body).set_attribute("class","on_web")

# Now make it public.
fhw = File.open("../public/history/index.html","w")
fhw.write(@index_hpricot.to_html)
fhw.close
