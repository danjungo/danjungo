require File.dirname(__FILE__) + '/../../test_helper'
require 'asnp/gcategs_controller'

# Re-raise errors caught by the controller.
class Asnp::GcategsController; def rescue_action(e) raise e end; end

class Asnp::GcategsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Asnp::GcategsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
