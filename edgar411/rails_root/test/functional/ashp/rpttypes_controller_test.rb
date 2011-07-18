require File.dirname(__FILE__) + '/../../test_helper'
require 'ashp/rpttypes_controller'

# Re-raise errors caught by the controller.
class Ashp::RpttypesController; def rescue_action(e) raise e end; end

class Ashp::RpttypesControllerTest < Test::Unit::TestCase
  def setup
    @controller = Ashp::RpttypesController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
