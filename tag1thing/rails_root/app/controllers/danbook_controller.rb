class DanbookController < ApplicationController
  filter_parameter_logging :fb_sig_friends
  def canvas_callback
    logger.info "session is: #{session.inspect}"
    render :layout => false
  end
end
