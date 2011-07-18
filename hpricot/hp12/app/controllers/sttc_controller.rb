# Serves up mostly static content.
class SttcController < ApplicationController
  # Open this controller to the world
  skip_before_filter :authenticate_usr

end # class
