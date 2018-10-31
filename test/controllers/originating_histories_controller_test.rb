require 'test_helper'

class OriginatingHistoriesControllerTest < ActionController::TestCase
  setup do
    @originating_history = originating_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:originating_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create originating_history" do
    assert_difference('OriginatingHistory.count') do
      post :create, originating_history: { article_id: @originating_history.article_id, article_source_id: @originating_history.article_source_id, originating_id: @originating_history.originating_id, revision_number: @originating_history.revision_number, user_id: @originating_history.user_id, workflow_transition_id: @originating_history.workflow_transition_id }
    end

    assert_redirected_to originating_history_path(assigns(:originating_history))
  end

  test "should show originating_history" do
    get :show, id: @originating_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @originating_history
    assert_response :success
  end

  test "should update originating_history" do
    patch :update, id: @originating_history, originating_history: { article_id: @originating_history.article_id, article_source_id: @originating_history.article_source_id, originating_id: @originating_history.originating_id, revision_number: @originating_history.revision_number, user_id: @originating_history.user_id, workflow_transition_id: @originating_history.workflow_transition_id }
    assert_redirected_to originating_history_path(assigns(:originating_history))
  end

  test "should destroy originating_history" do
    assert_difference('OriginatingHistory.count', -1) do
      delete :destroy, id: @originating_history
    end

    assert_redirected_to originating_histories_path
  end
end
