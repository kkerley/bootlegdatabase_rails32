require 'test_helper'

class BootlegsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bootlegs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bootleg" do
    assert_difference('Bootleg.count') do
      post :create, :bootleg => { }
    end

    assert_redirected_to bootleg_path(assigns(:bootleg))
  end

  test "should show bootleg" do
    get :show, :id => bootlegs(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => bootlegs(:one).to_param
    assert_response :success
  end

  test "should update bootleg" do
    put :update, :id => bootlegs(:one).to_param, :bootleg => { }
    assert_redirected_to bootleg_path(assigns(:bootleg))
  end

  test "should destroy bootleg" do
    assert_difference('Bootleg.count', -1) do
      delete :destroy, :id => bootlegs(:one).to_param
    end

    assert_redirected_to bootlegs_path
  end
end
