require 'test_helper'

class SpeakingHistoriesControllerTest < ActionController::TestCase
  setup do
    @speaking_history = speaking_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:speaking_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create speaking_history" do
    assert_difference('SpeakingHistory.count') do
      post :create, speaking_history: { article_id: @speaking_history.article_id, language_id: @speaking_history.language_id, revision_number: @speaking_history.revision_number, speaking_id: @speaking_history.speaking_id, user_id: @speaking_history.user_id, workflow_transition_id: @speaking_history.workflow_transition_id }
    end

    assert_redirected_to speaking_history_path(assigns(:speaking_history))
  end

  test "should show speaking_history" do
    get :show, id: @speaking_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @speaking_history
    assert_response :success
  end

  test "should update speaking_history" do
    patch :update, id: @speaking_history, speaking_history: { article_id: @speaking_history.article_id, language_id: @speaking_history.language_id, revision_number: @speaking_history.revision_number, speaking_id: @speaking_history.speaking_id, user_id: @speaking_history.user_id, workflow_transition_id: @speaking_history.workflow_transition_id }
    assert_redirected_to speaking_history_path(assigns(:speaking_history))
  end

  test "should destroy speaking_history" do
    assert_difference('SpeakingHistory.count', -1) do
      delete :destroy, id: @speaking_history
    end

    assert_redirected_to speaking_histories_path
  end
end
