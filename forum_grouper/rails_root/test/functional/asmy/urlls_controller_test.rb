require File.dirname(__FILE__) + '/../../test_helper'
require 'asmy/urlls_controller'

# Re-raise errors caught by the controller.
class Asmy::UrllsController; def rescue_action(e) raise e end; end

class Asmy::UrllsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Asmy::UrllsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
