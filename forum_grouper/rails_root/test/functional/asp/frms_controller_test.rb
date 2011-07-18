require File.dirname(__FILE__) + '/../../test_helper'
require 'asp/frms_controller'

# Re-raise errors caught by the controller.
class Asp::FrmsController; def rescue_action(e) raise e end; end

class Asp::FrmsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Asp::FrmsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
