# Provides read-only view via active_scaffold
class Asls::UsrsController < ApplicationController

  skip_before_filter :authenticate_usr

  active_scaffold do |config|
    config.label = "Owners/Authors Of Reports And Fragments"
    config.actions = [:list, :show, :search]
    config.list.columns = [:login, :email]
    config.show.columns = [:login, :email]
  end # active_scaffold
end
