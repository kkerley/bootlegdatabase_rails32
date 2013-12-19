require 'test_helper'

class PerformersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:performers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create performer" do
    assert_difference('Performer.count') do
      post :create, :performer => { }
    end

    assert_redirected_to performer_path(assigns(:performer))
  end

  test "should show performer" do
    get :show, :id => performers(:one).to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => performers(:one).to_param
    assert_response :success
  end

  test "should update performer" do
    put :update, :id => performers(:one).to_param, :performer => { }
    assert_redirected_to performer_path(assigns(:performer))
  end

  test "should destroy performer" do
    assert_difference('Performer.count', -1) do
      delete :destroy, :id => performers(:one).to_param
    end

    assert_redirected_to performers_path
  end
end
