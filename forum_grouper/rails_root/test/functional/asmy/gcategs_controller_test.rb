require File.dirname(__FILE__) + '/../../test_helper'
require 'asmy/gcategs_controller'

# Re-raise errors caught by the controller.
class Asmy::GcategsController; def rescue_action(e) raise e end; end

class Asmy::GcategsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Asmy::GcategsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
