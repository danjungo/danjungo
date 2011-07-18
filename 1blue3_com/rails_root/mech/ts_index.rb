#!/usr/bin/env ruby

# mech/ts_index.rb

# Builds the /public/s/index.html page by mixing /public/ts_index.html and some ruby.

require 'rubygems'
require 'mechanize'
require 'hpricot'

Hpricot.buffer_size = 321123

# Copy /public/ts_index.html into @ts_index_hpricot
@ts_index_hpricot = open("../public/ts_index.html"){ |f| Hpricot(f) }
# Add prominent timestamp
tms = Time.now.strftime("%Y-%m-%d %H:%M")
(@ts_index_hpricot/:ul).prepend("<li>This history captured at:<br />#{tms}<br />California Time</li>")

# Load /public/index.html into an @index_hpricot
# I intend to use ../public/index.html as a layout.
@index_hpricot = open("../public/index.html"){ |f| Hpricot(f) }

# Remove ul-element from @index_hpricot
(@index_hpricot/"ul#home").remove

# Append @ts_index_hpricot to body-element of @index_hpricot
(@index_hpricot/"body").append(@ts_index_hpricot.to_html)

# Signal that this page is on the web
@index_hpricot.at(:body).set_attribute("class","on_web")

fhw = File.open("../public/s/index.html","w")
fhw.write(@index_hpricot.to_html)
fhw.close
