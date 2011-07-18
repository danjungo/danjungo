class Ashp::BcrmbsController < ApplicationController

  active_scaffold do |config|
    config.actions = [:list, :show, :search]
  end
end #class
