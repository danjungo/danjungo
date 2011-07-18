require 'test_helper'

class ThngsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:thngs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create thng" do
    assert_difference('Thng.count') do
      post :create, :thng => { }
    end

    assert_redirected_to thng_path(assigns(:thng))
  end

  test "should show thng" do
    get :show, :id => thngs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => thngs(:one).to_param
    assert_response :success
  end

  test "should update thng" do
    put :update, :id => thngs(:one).to_param, :thng => { }
    assert_redirected_to thng_path(assigns(:thng))
  end

  test "should destroy thng" do
    assert_difference('Thng.count', -1) do
      delete :destroy, :id => thngs(:one).to_param
    end

    assert_redirected_to thngs_path
  end
end
