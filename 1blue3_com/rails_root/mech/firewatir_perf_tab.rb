#!/usr/bin/env ruby

# firewatir_perf_tab.rb

require 'rubygems'
require 'firewatir'
include FireWatir
ff=Firefox.new
ff.goto('https://z:1158/em/console/database/instance/sitemap?event=doLoad&target=orcl5.moi&type=oracle_database&pageNum=2')
sleep 5
ff.select_list(:name,"refreshChoice").option(:text, "Real Time: 1 Minute Refresh").select
