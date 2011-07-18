require File.dirname(__FILE__) + '/../../test_helper'
require 'ashp/exprtypes_controller'

# Re-raise errors caught by the controller.
class Ashp::ExprtypesController; def rescue_action(e) raise e end; end

class Ashp::ExprtypesControllerTest < Test::Unit::TestCase
  def setup
    @controller = Ashp::ExprtypesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
