require 'test_helper'

class UsrsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:usrs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create usr" do
    assert_difference('Usr.count') do
      post :create, :usr => { }
    end

    assert_redirected_to usr_path(assigns(:usr))
  end

  test "should show usr" do
    get :show, :id => usrs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => usrs(:one).to_param
    assert_response :success
  end

  test "should update usr" do
    put :update, :id => usrs(:one).to_param, :usr => { }
    assert_redirected_to usr_path(assigns(:usr))
  end

  test "should destroy usr" do
    assert_difference('Usr.count', -1) do
      delete :destroy, :id => usrs(:one).to_param
    end

    assert_redirected_to usrs_path
  end
end
