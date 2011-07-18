#!/usr/bin/env ruby

# mech/about.rb

# Builds the /public/s/about.html page by mixing /public/index.html and /public/about.html

require 'rubygems'
require 'mechanize'
require 'hpricot'

Hpricot.buffer_size = 321123

# Get a copy of the public/index.html,
# I want to use it as a layout.
@docidx = open("../public/index.html"){ |f| Hpricot(f) }
# I get the about_html from /public/about.html 
@docabout = open("../public/about.html"){ |f| Hpricot(f) }
# Mix-in about-HTML
(@docidx/"ul#home").remove
(@docidx/"body").prepend(@docabout.to_html)
# Now publish it
fhw = File.open("../public/s/about.html","w")
fhw.write(@docidx.to_html)
fhw.close
