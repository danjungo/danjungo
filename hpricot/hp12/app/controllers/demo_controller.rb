# This is a demo controller

require 'rubygems'
require 'hpricot'
require 'open-uri'

class DemoController < ActionController::Base
  # Open this controller to the world
  skip_before_filter :authenticate_usr

  # I help Hpricot
  Hpricot.buffer_size = 262144

  # Null out the parse() method of  WebAgent::CookieManager so it cannot save cookies
  module Tst
    class WebAgent::CookieManager
      # Empty parse method which nulls out the effect of the real parse()
      def parse x, y
        @index = "nada"
      end # parse
    end # class
  end # module

  def search_google
    myurl = "http://www.google.com"
    mysearch_expression = "div.gb2/a[@href^='http']"
    hpricot_object = get_my_hp_elem(myurl)
    @somehtml = hpricot_object.search(mysearch_expression).to_html
  end


  protected

  # Returns raw HTML.  Usually it gets passed to get_my_hp_elem()
  def get_my_html_from_open_uri(u)
    hdrs = {"User-Agent"=>"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1", "Accept-Charset"=>"utf-8", "Connection"=>"Keep-Alive", "Accept"=>"text/html"}
    my_html = ""
    begin
      open(u, hdrs).each {|s| my_html << s}
    rescue
      my_html = "<html><body><p /><b>hello world</b></body></html>"
    end
    return my_html
  end # get_my_html_from_open_uri()

  # Returns an Hpricot object from HTML obtained by get_my_html_from_open_uri()
  def get_my_hp_elem(u)
    h0 = Hpricot(get_my_html_from_open_uri(u))
    # remove crap
    # (h0/"script").remove
    return h0
  end # get_my_hp_elem()

end # class



