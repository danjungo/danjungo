require File.dirname(__FILE__) + '/../test_helper'
require 'stcks_controller'

# Re-raise errors caught by the controller.
class StcksController; def rescue_action(e) raise e end; end

class StcksControllerTest < Test::Unit::TestCase
  def setup
    @controller = StcksController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
