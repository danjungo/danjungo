class WelcomeController < ApplicationController
  def index
  end
  def new_theme
    session[:ccolor_theme]= params["select_theme"]
  end

end
