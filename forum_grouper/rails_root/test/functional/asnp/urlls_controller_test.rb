require File.dirname(__FILE__) + '/../../test_helper'
require 'asnp/urlls_controller'

# Re-raise errors caught by the controller.
class Asnp::UrllsController; def rescue_action(e) raise e end; end

class Asnp::UrllsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Asnp::UrllsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
