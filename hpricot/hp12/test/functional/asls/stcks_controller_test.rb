require File.dirname(__FILE__) + '/../../test_helper'
require 'asls/stcks_controller'

# Re-raise errors caught by the controller.
class Asls::StcksController; def rescue_action(e) raise e end; end

class Asls::StcksControllerTest < Test::Unit::TestCase
  def setup
    @controller = Asls::StcksController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
