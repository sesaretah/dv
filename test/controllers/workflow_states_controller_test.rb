require 'test_helper'

class WorkflowStatesControllerTest < ActionController::TestCase
  setup do
    @workflow_state = workflow_states(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workflow_states)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workflow_state" do
    assert_difference('WorkflowState.count') do
      post :create, workflow_state: { title: @workflow_state.title, workflow_id: @workflow_state.workflow_id }
    end

    assert_redirected_to workflow_state_path(assigns(:workflow_state))
  end

  test "should show workflow_state" do
    get :show, id: @workflow_state
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @workflow_state
    assert_response :success
  end

  test "should update workflow_state" do
    patch :update, id: @workflow_state, workflow_state: { title: @workflow_state.title, workflow_id: @workflow_state.workflow_id }
    assert_redirected_to workflow_state_path(assigns(:workflow_state))
  end

  test "should destroy workflow_state" do
    assert_difference('WorkflowState.count', -1) do
      delete :destroy, id: @workflow_state
    end

    assert_redirected_to workflow_states_path
  end
end
