require 'test_helper'

class TaggingHistoriesControllerTest < ActionController::TestCase
  setup do
    @tagging_history = tagging_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tagging_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tagging_history" do
    assert_difference('TaggingHistory.count') do
      post :create, tagging_history: { article_id: @tagging_history.article_id, revision_number: @tagging_history.revision_number, taggable_id: @tagging_history.taggable_id, taggable_type: @tagging_history.taggable_type, target_id: @tagging_history.target_id, target_type: @tagging_history.target_type, user_id: @tagging_history.user_id, workflow_transition_id: @tagging_history.workflow_transition_id }
    end

    assert_redirected_to tagging_history_path(assigns(:tagging_history))
  end

  test "should show tagging_history" do
    get :show, id: @tagging_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @tagging_history
    assert_response :success
  end

  test "should update tagging_history" do
    patch :update, id: @tagging_history, tagging_history: { article_id: @tagging_history.article_id, revision_number: @tagging_history.revision_number, taggable_id: @tagging_history.taggable_id, taggable_type: @tagging_history.taggable_type, target_id: @tagging_history.target_id, target_type: @tagging_history.target_type, user_id: @tagging_history.user_id, workflow_transition_id: @tagging_history.workflow_transition_id }
    assert_redirected_to tagging_history_path(assigns(:tagging_history))
  end

  test "should destroy tagging_history" do
    assert_difference('TaggingHistory.count', -1) do
      delete :destroy, id: @tagging_history
    end

    assert_redirected_to tagging_histories_path
  end
end
