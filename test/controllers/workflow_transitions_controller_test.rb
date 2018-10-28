require 'test_helper'

class WorkflowTransitionsControllerTest < ActionController::TestCase
  setup do
    @workflow_transition = workflow_transitions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workflow_transitions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workflow_transition" do
    assert_difference('WorkflowTransition.count') do
      post :create, workflow_transition: { from_state_id: @workflow_transition.from_state_id, message: @workflow_transition.message, role_id: @workflow_transition.role_id, to_state_id: @workflow_transition.to_state_id, transition_type: @workflow_transition.transition_type, user_id: @workflow_transition.user_id, workflow_id: @workflow_transition.workflow_id }
    end

    assert_redirected_to workflow_transition_path(assigns(:workflow_transition))
  end

  test "should show workflow_transition" do
    get :show, id: @workflow_transition
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @workflow_transition
    assert_response :success
  end

  test "should update workflow_transition" do
    patch :update, id: @workflow_transition, workflow_transition: { from_state_id: @workflow_transition.from_state_id, message: @workflow_transition.message, role_id: @workflow_transition.role_id, to_state_id: @workflow_transition.to_state_id, transition_type: @workflow_transition.transition_type, user_id: @workflow_transition.user_id, workflow_id: @workflow_transition.workflow_id }
    assert_redirected_to workflow_transition_path(assigns(:workflow_transition))
  end

  test "should destroy workflow_transition" do
    assert_difference('WorkflowTransition.count', -1) do
      delete :destroy, id: @workflow_transition
    end

    assert_redirected_to workflow_transitions_path
  end
end
