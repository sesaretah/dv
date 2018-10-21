require 'test_helper'

class AreaingsControllerTest < ActionController::TestCase
  setup do
    @areaing = areaings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:areaings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create areaing" do
    assert_difference('Areaing.count') do
      post :create, areaing: { article_area_id: @areaing.article_area_id, article_id: @areaing.article_id }
    end

    assert_redirected_to areaing_path(assigns(:areaing))
  end

  test "should show areaing" do
    get :show, id: @areaing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @areaing
    assert_response :success
  end

  test "should update areaing" do
    patch :update, id: @areaing, areaing: { article_area_id: @areaing.article_area_id, article_id: @areaing.article_id }
    assert_redirected_to areaing_path(assigns(:areaing))
  end

  test "should destroy areaing" do
    assert_difference('Areaing.count', -1) do
      delete :destroy, id: @areaing
    end

    assert_redirected_to areaings_path
  end
end
