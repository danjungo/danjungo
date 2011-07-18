require File.dirname(__FILE__) + '/../../test_helper'
require 'tst/usrs_controller'

# Re-raise errors caught by the controller.
class Tst::UsrsController; def rescue_action(e) raise e end; end

class Tst::UsrsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Tst::UsrsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
