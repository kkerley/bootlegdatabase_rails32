require 'test_helper'

class ToursControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tour" do
    assert_difference('Tour.count') do
      post :create, :tour => { }
    end

    assert_redirected_to tour_path(assigns(:tour))
  end

  test "should show tour" do
    get :show, :id => tours(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tours(:one).to_param
    assert_response :success
  end

  test "should update tour" do
    put :update, :id => tours(:one).to_param, :tour => { }
    assert_redirected_to tour_path(assigns(:tour))
  end

  test "should destroy tour" do
    assert_difference('Tour.count', -1) do
      delete :destroy, :id => tours(:one).to_param
    end

    assert_redirected_to tours_path
  end
end
