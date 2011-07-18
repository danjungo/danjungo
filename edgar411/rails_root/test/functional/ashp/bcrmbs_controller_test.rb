require File.dirname(__FILE__) + '/../../test_helper'
require 'ashp/bcrmbs_controller'

# Re-raise errors caught by the controller.
class Ashp::BcrmbsController; def rescue_action(e) raise e end; end

class Ashp::BcrmbsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Ashp::BcrmbsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
