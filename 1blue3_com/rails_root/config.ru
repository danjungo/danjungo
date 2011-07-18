## # Rack Dispatcher
## 
## # Require your environment file to bootstrap Rails
## require File.dirname(__FILE__) + '/config/environment'
## 
## # Dispatch the request
## run ActionController::Dispatcher.new

# works with heroku

require "config/environment"

use Rails::Rack::LogTailer
use Rails::Rack::Static
run ActionController::Dispatcher.new
