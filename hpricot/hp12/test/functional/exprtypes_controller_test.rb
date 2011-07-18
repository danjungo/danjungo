require File.dirname(__FILE__) + '/../test_helper'
require 'exprtypes_controller'

# Re-raise errors caught by the controller.
class ExprtypesController; def rescue_action(e) raise e end; end

class ExprtypesControllerTest < Test::Unit::TestCase
  def setup
    @controller = ExprtypesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
