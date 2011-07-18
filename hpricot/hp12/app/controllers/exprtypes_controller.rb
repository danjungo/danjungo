class ExprtypesController < ApplicationController
  # active_scaffold creates powerful JS based forms.  See http://activescaffold.com
  active_scaffold do |config|
    config.actions = [:list, :show]
  end # active_scaffold
end
