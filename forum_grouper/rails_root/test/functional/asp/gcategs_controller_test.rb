require File.dirname(__FILE__) + '/../../test_helper'
require 'asp/gcategs_controller'

# Re-raise errors caught by the controller.
class Asp::GcategsController; def rescue_action(e) raise e end; end

class Asp::GcategsControllerTest < Test::Unit::TestCase
  def setup
    @controller = Asp::GcategsController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
