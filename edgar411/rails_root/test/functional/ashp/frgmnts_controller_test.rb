require File.dirname(__FILE__) + '/../../test_helper'
require 'ashp/frgmnts_controller'

# Re-raise errors caught by the controller.
class Ashp::FrgmntsController; def rescue_action(e) raise e end; end

class Ashp::FrgmntsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Ashp::FrgmntsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
