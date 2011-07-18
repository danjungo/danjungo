require File.dirname(__FILE__) + '/../../test_helper'
require 'asnp/frms_controller'

# Re-raise errors caught by the controller.
class Asnp::FrmsController; def rescue_action(e) raise e end; end

class Asnp::FrmsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Asnp::FrmsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
