require File.dirname(__FILE__) + '/../test_helper'
require 'frgmnts_controller'

# Re-raise errors caught by the controller.
class FrgmntsController; def rescue_action(e) raise e end; end

class FrgmntsControllerTest < Test::Unit::TestCase
  def setup
    @controller = FrgmntsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
