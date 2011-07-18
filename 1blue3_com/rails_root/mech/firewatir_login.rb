#!/usr/bin/env ruby

# firewatir_login.rb

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

