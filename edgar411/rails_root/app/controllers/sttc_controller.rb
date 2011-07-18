class SttcController < ApplicationController
  skip_before_filter :authenticate_usr
  def index
  end
end
