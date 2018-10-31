require 'test_helper'

class ContributionHistoriesControllerTest < ActionController::TestCase
  setup do
    @contribution_history = contribution_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contribution_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contribution_history" do
    assert_difference('ContributionHistory.count') do
      post :create, contribution_history: { article_id: @contribution_history.article_id, contribution_id: @contribution_history.contribution_id, duty_id: @contribution_history.duty_id, profile_id: @contribution_history.profile_id, revision_number: @contribution_history.revision_number, role_id: @contribution_history.role_id, user_id: @contribution_history.user_id, workflow_transition_id: @contribution_history.workflow_transition_id }
    end

    assert_redirected_to contribution_history_path(assigns(:contribution_history))
  end

  test "should show contribution_history" do
    get :show, id: @contribution_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contribution_history
    assert_response :success
  end

  test "should update contribution_history" do
    patch :update, id: @contribution_history, contribution_history: { article_id: @contribution_history.article_id, contribution_id: @contribution_history.contribution_id, duty_id: @contribution_history.duty_id, profile_id: @contribution_history.profile_id, revision_number: @contribution_history.revision_number, role_id: @contribution_history.role_id, user_id: @contribution_history.user_id, workflow_transition_id: @contribution_history.workflow_transition_id }
    assert_redirected_to contribution_history_path(assigns(:contribution_history))
  end

  test "should destroy contribution_history" do
    assert_difference('ContributionHistory.count', -1) do
      delete :destroy, id: @contribution_history
    end

    assert_redirected_to contribution_histories_path
  end
end
