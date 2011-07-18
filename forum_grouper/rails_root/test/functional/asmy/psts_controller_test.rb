require File.dirname(__FILE__) + '/../../test_helper'
require 'asmy/psts_controller'

# Re-raise errors caught by the controller.
class Asmy::PstsController; def rescue_action(e) raise e end; end

class Asmy::PstsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Asmy::PstsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
