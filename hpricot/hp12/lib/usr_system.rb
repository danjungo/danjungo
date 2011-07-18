module UsrSystem

  protected

  # authenticate_usr filter. add
  #
  #   before_filter :authenticate_usr
  #
  def authenticate_usr
    return true if authenticated_usr?
    session[:return_to] = request.request_uri
    access_denied
    return false 
  end

  # overwrite if you want to have special behavior in case the usr is not authorized
  # to access the current operation. 
  # the default action is to redirect to the login screen
  # example use :
  # a popup window might just close itself for instance
  def access_denied
    redirect_to :controller => "/usr", :action => "login"
  end  

  def redirect_back_or_default(default)
    if session[:return_to].nil?
      redirect_to default
    else
      redirect_to_url session[:return_to]
      session[:return_to] = nil
    end
  end

  def authenticated_usr?
    if session[:usr_id]
      @current_usr = Usr.find_by_id(session[:usr_id])
      return false if @current_usr.nil? 
      return true
    end

    # If not, is the usr being authenticated by a token (created by signup/forgot password actions)?
    return false if not params['usr']
    id = params['usr']['id']
    key = params['key']
    if id and key
      @current_usr = Usr.authenticate_by_token(id, key)
      session[:usr_id] = @current_usr ? @current_usr.id : nil
      return true if not @current_usr.nil?
    end

    # Everything failed
    return false
  end
end
