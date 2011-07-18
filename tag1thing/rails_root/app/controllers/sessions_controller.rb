class SessionsController < ApplicationController
  def logout
    session[:usrnm]= session[:opndd]= "Guest"
  end

end
