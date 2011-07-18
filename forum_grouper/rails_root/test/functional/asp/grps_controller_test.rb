require File.dirname(__FILE__) + '/../../test_helper'
require 'asp/grps_controller'

# Re-raise errors caught by the controller.
class Asp::GrpsController; def rescue_action(e) raise e end; end

class Asp::GrpsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Asp::GrpsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
