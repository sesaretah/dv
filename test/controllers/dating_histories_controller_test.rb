require 'test_helper'

class DatingHistoriesControllerTest < ActionController::TestCase
  setup do
    @dating_history = dating_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dating_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dating_history" do
    assert_difference('DatingHistory.count') do
      post :create, dating_history: { article_event_id: @dating_history.article_event_id, article_id: @dating_history.article_id, event_date: @dating_history.event_date, revision_number: @dating_history.revision_number, user_id: @dating_history.user_id, workflow_transition_id: @dating_history.workflow_transition_id }
    end

    assert_redirected_to dating_history_path(assigns(:dating_history))
  end

  test "should show dating_history" do
    get :show, id: @dating_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dating_history
    assert_response :success
  end

  test "should update dating_history" do
    patch :update, id: @dating_history, dating_history: { article_event_id: @dating_history.article_event_id, article_id: @dating_history.article_id, event_date: @dating_history.event_date, revision_number: @dating_history.revision_number, user_id: @dating_history.user_id, workflow_transition_id: @dating_history.workflow_transition_id }
    assert_redirected_to dating_history_path(assigns(:dating_history))
  end

  test "should destroy dating_history" do
    assert_difference('DatingHistory.count', -1) do
      delete :destroy, id: @dating_history
    end

    assert_redirected_to dating_histories_path
  end
end
