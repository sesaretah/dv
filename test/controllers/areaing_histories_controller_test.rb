require 'test_helper'

class AreaingHistoriesControllerTest < ActionController::TestCase
  setup do
    @areaing_history = areaing_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:areaing_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create areaing_history" do
    assert_difference('AreaingHistory.count') do
      post :create, areaing_history: { areaing_id: @areaing_history.areaing_id, article_area_id: @areaing_history.article_area_id, article_id: @areaing_history.article_id, revision_number: @areaing_history.revision_number, user_id: @areaing_history.user_id, workflow_transition_id: @areaing_history.workflow_transition_id }
    end

    assert_redirected_to areaing_history_path(assigns(:areaing_history))
  end

  test "should show areaing_history" do
    get :show, id: @areaing_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @areaing_history
    assert_response :success
  end

  test "should update areaing_history" do
    patch :update, id: @areaing_history, areaing_history: { areaing_id: @areaing_history.areaing_id, article_area_id: @areaing_history.article_area_id, article_id: @areaing_history.article_id, revision_number: @areaing_history.revision_number, user_id: @areaing_history.user_id, workflow_transition_id: @areaing_history.workflow_transition_id }
    assert_redirected_to areaing_history_path(assigns(:areaing_history))
  end

  test "should destroy areaing_history" do
    assert_difference('AreaingHistory.count', -1) do
      delete :destroy, id: @areaing_history
    end

    assert_redirected_to areaing_histories_path
  end
end
