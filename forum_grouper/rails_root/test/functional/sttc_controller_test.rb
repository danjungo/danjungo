require File.dirname(__FILE__) + '/../test_helper'
require 'sttc_controller'

# Re-raise errors caught by the controller.
class SttcController; def rescue_action(e) raise e end; end

class SttcControllerTest < Test::Unit::TestCase
  def setup
    @controller = SttcController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
