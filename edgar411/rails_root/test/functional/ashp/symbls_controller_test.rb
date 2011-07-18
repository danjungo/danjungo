require File.dirname(__FILE__) + '/../../test_helper'
require 'ashp/symbls_controller'

# Re-raise errors caught by the controller.
class Ashp::SymblsController; def rescue_action(e) raise e end; end

class Ashp::SymblsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Ashp::SymblsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
