require 'test_helper'

class TypingHistoriesControllerTest < ActionController::TestCase
  setup do
    @typing_history = typing_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:typing_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create typing_history" do
    assert_difference('TypingHistory.count') do
      post :create, typing_history: { article_id: @typing_history.article_id, article_type_id: @typing_history.article_type_id, revision_number: @typing_history.revision_number, typing_id: @typing_history.typing_id, user_id: @typing_history.user_id, workflow_transition_id: @typing_history.workflow_transition_id }
    end

    assert_redirected_to typing_history_path(assigns(:typing_history))
  end

  test "should show typing_history" do
    get :show, id: @typing_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @typing_history
    assert_response :success
  end

  test "should update typing_history" do
    patch :update, id: @typing_history, typing_history: { article_id: @typing_history.article_id, article_type_id: @typing_history.article_type_id, revision_number: @typing_history.revision_number, typing_id: @typing_history.typing_id, user_id: @typing_history.user_id, workflow_transition_id: @typing_history.workflow_transition_id }
    assert_redirected_to typing_history_path(assigns(:typing_history))
  end

  test "should destroy typing_history" do
    assert_difference('TypingHistory.count', -1) do
      delete :destroy, id: @typing_history
    end

    assert_redirected_to typing_histories_path
  end
end
