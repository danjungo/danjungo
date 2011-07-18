class Asmy::UsrsController < ApplicationController

  # Provide minimal active_scaffold functionality
  active_scaffold do |config|
    config.label = "User/Owner information"
    config.actions = [:list, :show, :search]
    config.list.columns = [:login, :email]
    config.show.columns = [:login, :email]
  end # active_scaffold
end # class
