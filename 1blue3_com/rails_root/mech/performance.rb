#!/usr/bin/env ruby

# mech/performance.rb

# gets performance portion of em

require 'rubygems'
require 'hpricot'

Hpricot.buffer_size = 321123
# Get a copy of the public/index.html,
# I want to use it as a layout.
@docidx = open("../public/index.html"){ |f| Hpricot(f) }
# remove the ul-element
(@docidx/"ul#home").remove
# Mix-in perf_html kept in a file
@docperf = open("../public/performance.html"){ |f| Hpricot(f) }
(@docidx/"body").prepend(@docperf.to_html)
# Consider this page to be on_web rather than in_phone.
@docidx.at(:body).set_attribute("class","on_web")
perf_html_wrapped = @docidx.to_html
# Now make it public.
fhw = File.open("../public/s/performance/index.html","w")
fhw.write(perf_html_wrapped)
fhw.close
