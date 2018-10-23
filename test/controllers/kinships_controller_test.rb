require 'test_helper'

class KinshipsControllerTest < ActionController::TestCase
  setup do
    @kinship = kinships(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kinships)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kinship" do
    assert_difference('Kinship.count') do
      post :create, kinship: { kin_id: @kinship.kin_id, user_id: @kinship.user_id }
    end

    assert_redirected_to kinship_path(assigns(:kinship))
  end

  test "should show kinship" do
    get :show, id: @kinship
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kinship
    assert_response :success
  end

  test "should update kinship" do
    patch :update, id: @kinship, kinship: { kin_id: @kinship.kin_id, user_id: @kinship.user_id }
    assert_redirected_to kinship_path(assigns(:kinship))
  end

  test "should destroy kinship" do
    assert_difference('Kinship.count', -1) do
      delete :destroy, id: @kinship
    end

    assert_redirected_to kinships_path
  end
end
