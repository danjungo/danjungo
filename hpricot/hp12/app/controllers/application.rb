# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

require 'usr_system'
require 'rubygems'
require 'hpricot'
require 'open-uri'

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_hp12_session_id'
  include ERB::Util
  include UsrSystem
  helper :usr
  before_filter :authenticate_usr
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

  # Method for rendering the HTML in a Fragment
  def rndr_frgmnt
    @somehtml = Frgmnt.find(params[:id]).frgtxt
    render(:layout => "layouts/layout4rndr")
  end # rndr_frgmnt

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

  # Repel users who manually tinker with id in the request URL
  def repel_them
    # I dont need to repel_them if id is nil
    return if (params[:id] == nil)

    # Get the model class loaded into an object which can also be a class
    myklass = self.active_scaffold_config.model
    # Use the object-class-beastie to run .find() against the id in the request URL
    the_obj = myklass.find(params[:id])
    # Find out who owns the_obj
    the_usr_id = the_obj.send(:usr_id)
    # Repel them if they dont own the object pointed to by the id in the request URL
    redirect_to("/") unless the_usr_id == session[:usr_id]
  end

end # class

