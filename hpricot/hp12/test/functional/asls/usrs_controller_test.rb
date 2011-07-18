require File.dirname(__FILE__) + '/../../test_helper'
require 'asls/usrs_controller'

# Re-raise errors caught by the controller.
class Asls::UsrsController; def rescue_action(e) raise e end; end

class Asls::UsrsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Asls::UsrsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
