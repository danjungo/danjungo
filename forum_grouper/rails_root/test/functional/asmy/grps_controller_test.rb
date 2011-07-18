require File.dirname(__FILE__) + '/../../test_helper'
require 'asmy/grps_controller'

# Re-raise errors caught by the controller.
class Asmy::GrpsController; def rescue_action(e) raise e end; end

class Asmy::GrpsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Asmy::GrpsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
