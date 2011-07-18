class Ashp::RpttypesController < ApplicationController

  active_scaffold do |config|
    config.actions = [:list, :show, :search]
  end
end # class
