class Asls::StcksController < ApplicationController
  skip_before_filter :authenticate_usr
  # active_scaffold creates powerful JS based forms.  See http://activescaffold.com
  active_scaffold do |config|
    config.actions = [:list, :show]
  end # active_scaffold
end # class

