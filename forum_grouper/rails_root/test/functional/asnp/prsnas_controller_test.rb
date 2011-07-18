require File.dirname(__FILE__) + '/../../test_helper'
require 'asnp/prsnas_controller'

# Re-raise errors caught by the controller.
class Asnp::PrsnasController; def rescue_action(e) raise e end; end

class Asnp::PrsnasControllerTest < Test::Unit::TestCase
  def setup
    @controller = Asnp::PrsnasController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new
  end

  # Replace this with your real tests.
  def test_truth
    assert true
  end
end
