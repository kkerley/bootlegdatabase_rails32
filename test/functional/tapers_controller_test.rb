require 'test_helper'

class TapersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tapers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create taper" do
    assert_difference('Taper.count') do
      post :create, :taper => { }
    end

    assert_redirected_to taper_path(assigns(:taper))
  end

  test "should show taper" do
    get :show, :id => tapers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => tapers(:one).to_param
    assert_response :success
  end

  test "should update taper" do
    put :update, :id => tapers(:one).to_param, :taper => { }
    assert_redirected_to taper_path(assigns(:taper))
  end

  test "should destroy taper" do
    assert_difference('Taper.count', -1) do
      delete :destroy, :id => tapers(:one).to_param
    end

    assert_redirected_to tapers_path
  end
end
