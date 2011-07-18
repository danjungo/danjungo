class AjaxController < ApplicationController

  # before_filter :trim_double_slash
  def trim_double_slash
    if request.request_uri=~ /^\/\//
      # I am not sure I can trim a double slash in the request
    end # if request.request_uri
  end # def trim_double_slash

  def index
    @myrequest= request
  end

  def ensure_application_is_installed_by_facebook_user
    super unless request.request_uri=~ /^\/\//
  end

end
