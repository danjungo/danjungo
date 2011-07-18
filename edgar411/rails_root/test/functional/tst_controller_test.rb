require File.dirname(__FILE__) + '/../test_helper'
require 'tst_controller'

# Re-raise errors caught by the controller.
class TstController; def rescue_action(e) raise e end; end

class TstControllerTest < Test::Unit::TestCase
  def setup
    @controller = TstController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
