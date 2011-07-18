# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

# usr_system is part of login_sugar
require 'usr_system'

class ApplicationController < ActionController::Base
  # Pick a unique cookie name to distinguish our session data from others'
  session :session_key => '_e11_session_id'

  # can these go above the class def like usr_system?
  require 'rubygems'
  require 'hpricot'
  require 'open-uri'

  include ERB::Util
  include UsrSystem
  helper :usr
  before_filter :pickup_breadcrumbs
  before_filter :authenticate_usr

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

  # Inspect every request for a breadcrumb key.
  # If I find one, pull an HTML-breadcrumb out of the DB and expose it to any view which wants it.
  def pickup_breadcrumbs
    @bcname = request.path.inspect
    case
    when request.path == "/"
      @bcname = Bcrmb.find_by_bckey("home").name
    when request.path =~ /(\/as\w\w\/)(\w+)/
      token2in_path = $2
      if (mybc = Bcrmb.find_by_bckey(token2in_path))
        @bcname = mybc.send(:name)
      else
        @bcname = Bcrmb.find_by_bckey("allbc").name
      end # if
    else
      @bcname = Bcrmb.find_by_bckey("allbc").name
    end # case

  end # pickup_breadcrumbs
end # class
