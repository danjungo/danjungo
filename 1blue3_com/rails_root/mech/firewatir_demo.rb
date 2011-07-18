#!/usr/bin/env ruby

# firewatir_demo.rb

# simple demo of firewatir

require 'rubygems'
require 'firewatir'
include FireWatir
ff=Firefox.new
ff.goto("https://z:1158/em/console/logon/logon")
sleep 5
# Login
ff.text_field(:name,"userName").set("trade")
sleep 1
ff.text_field(:name,"userPassword").set("t")
sleep 1
ff.form(:name, 'User').submit
sleep 5
# ff.select_list(:name,"refreshChoice").option(:text, "Real Time: Manual Refresh").select
# ff.link(:xpath , "//a[contains(.,'Performance')]").exist?
# ff.link(:text , "Performance").exist?
# ff.link(:text , "Performance").click
ff.goto('https://z:1158/em/console/database/instance/sitemap?event=doLoad&target=orcl5.moi&type=oracle_database&pageNum=2')
sleep 5
ff.select_list(:name,"refreshChoice").option(:text, "Real Time: 1 Minute Refresh").select
