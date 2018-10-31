require 'test_helper'

class FormatingHistoriesControllerTest < ActionController::TestCase
  setup do
    @formating_history = formating_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:formating_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create formating_history" do
    assert_difference('FormatingHistory.count') do
      post :create, formating_history: { article_format_id: @formating_history.article_format_id, article_id: @formating_history.article_id, formating_id: @formating_history.formating_id, revision_number: @formating_history.revision_number, user_id: @formating_history.user_id, workflow_state_id: @formating_history.workflow_state_id }
    end

    assert_redirected_to formating_history_path(assigns(:formating_history))
  end

  test "should show formating_history" do
    get :show, id: @formating_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @formating_history
    assert_response :success
  end

  test "should update formating_history" do
    patch :update, id: @formating_history, formating_history: { article_format_id: @formating_history.article_format_id, article_id: @formating_history.article_id, formating_id: @formating_history.formating_id, revision_number: @formating_history.revision_number, user_id: @formating_history.user_id, workflow_state_id: @formating_history.workflow_state_id }
    assert_redirected_to formating_history_path(assigns(:formating_history))
  end

  test "should destroy formating_history" do
    assert_difference('FormatingHistory.count', -1) do
      delete :destroy, id: @formating_history
    end

    assert_redirected_to formating_histories_path
  end
end
