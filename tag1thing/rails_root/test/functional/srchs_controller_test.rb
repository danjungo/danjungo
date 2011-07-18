require 'test_helper'

class SrchsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:srchs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create srch" do
    assert_difference('Srch.count') do
      post :create, :srch => { }
    end

    assert_redirected_to srch_path(assigns(:srch))
  end

  test "should show srch" do
    get :show, :id => srchs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => srchs(:one).to_param
    assert_response :success
  end

  test "should update srch" do
    put :update, :id => srchs(:one).to_param, :srch => { }
    assert_redirected_to srch_path(assigns(:srch))
  end

  test "should destroy srch" do
    assert_difference('Srch.count', -1) do
      delete :destroy, :id => srchs(:one).to_param
    end

    assert_redirected_to srchs_path
  end
end
