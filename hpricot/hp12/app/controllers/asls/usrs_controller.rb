class Asls::UsrsController < ApplicationController
  skip_before_filter :authenticate_usr
  # active_scaffold creates powerful JS based forms.  See http://activescaffold.com
  # Provide minimal active_scaffold functionality
  active_scaffold do |config|
    config.label = "User/Owner information"
    config.actions = [:list, :show]
    config.list.columns = [:login, :email]
    config.show.columns = [:login, :email]
  end # active_scaffold
end
