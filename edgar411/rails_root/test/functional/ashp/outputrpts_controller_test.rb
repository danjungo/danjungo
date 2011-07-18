require File.dirname(__FILE__) + '/../../test_helper'
require 'ashp/outputrpts_controller'

# Re-raise errors caught by the controller.
class Ashp::OutputrptsController; def rescue_action(e) raise e end; end

class Ashp::OutputrptsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Ashp::OutputrptsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
