require File.dirname(__FILE__) + '/../../test_helper'
require 'asmy/prsnas_controller'

# Re-raise errors caught by the controller.
class Asmy::PrsnasController; def rescue_action(e) raise e end; end

class Asmy::PrsnasControllerTest < Test::Unit::TestCase
  def setup
    @controller = Asmy::PrsnasController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
