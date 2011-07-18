# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require 'hpricot'
require 'open-uri'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  # I help Hpricot
  Hpricot.buffer_size = 262144

  # Returns raw HTML.  Usually it gets passed to get_my_hp_elem()
  def get_my_html_from_open_uri(u)
    hdrs = {"User-Agent"=>"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1", "Accept-Charset"=>"utf-8", "Accept"=>"text/html"}
    my_html = ""
    open(u, hdrs).each {|s| my_html << s}
    return my_html
  end # get_my_html_from_open_uri()

  # Returns an Hpricot object from HTML obtained by get_my_html_from_open_uri()
  def get_my_hp_elem(u)
    h0 = Hpricot(get_my_html_from_open_uri(u))
    # remove crap
    # (h0/"script").remove
    return h0
  end # get_my_hp_elem()

  # Useful helper normally used in the view.
  def h(s)
    ERB::Util.html_escape(s)
  end

end
