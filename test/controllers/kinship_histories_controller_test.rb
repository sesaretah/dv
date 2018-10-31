require 'test_helper'

class KinshipHistoriesControllerTest < ActionController::TestCase
  setup do
    @kinship_history = kinship_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:kinship_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create kinship_history" do
    assert_difference('KinshipHistory.count') do
      post :create, kinship_history: { article_id: @kinship_history.article_id, article_relation_type_id: @kinship_history.article_relation_type_id, kin_id: @kinship_history.kin_id, revision_number: @kinship_history.revision_number, user_id: @kinship_history.user_id, user_id: @kinship_history.user_id, workflow_transition_id: @kinship_history.workflow_transition_id }
    end

    assert_redirected_to kinship_history_path(assigns(:kinship_history))
  end

  test "should show kinship_history" do
    get :show, id: @kinship_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @kinship_history
    assert_response :success
  end

  test "should update kinship_history" do
    patch :update, id: @kinship_history, kinship_history: { article_id: @kinship_history.article_id, article_relation_type_id: @kinship_history.article_relation_type_id, kin_id: @kinship_history.kin_id, revision_number: @kinship_history.revision_number, user_id: @kinship_history.user_id, user_id: @kinship_history.user_id, workflow_transition_id: @kinship_history.workflow_transition_id }
    assert_redirected_to kinship_history_path(assigns(:kinship_history))
  end

  test "should destroy kinship_history" do
    assert_difference('KinshipHistory.count', -1) do
      delete :destroy, id: @kinship_history
    end

    assert_redirected_to kinship_histories_path
  end
end
