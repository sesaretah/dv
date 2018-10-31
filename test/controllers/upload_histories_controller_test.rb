require 'test_helper'

class UploadHistoriesControllerTest < ActionController::TestCase
  setup do
    @upload_history = upload_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:upload_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create upload_history" do
    assert_difference('UploadHistory.count') do
      post :create, upload_history: { attachment_type: @upload_history.attachment_type, revision_number: @upload_history.revision_number, speaking_id: @upload_history.speaking_id, token: @upload_history.token, uploadable_id: @upload_history.uploadable_id, uploadable_type: @upload_history.uploadable_type, user_id: @upload_history.user_id, workflow_transition_id: @upload_history.workflow_transition_id }
    end

    assert_redirected_to upload_history_path(assigns(:upload_history))
  end

  test "should show upload_history" do
    get :show, id: @upload_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @upload_history
    assert_response :success
  end

  test "should update upload_history" do
    patch :update, id: @upload_history, upload_history: { attachment_type: @upload_history.attachment_type, revision_number: @upload_history.revision_number, speaking_id: @upload_history.speaking_id, token: @upload_history.token, uploadable_id: @upload_history.uploadable_id, uploadable_type: @upload_history.uploadable_type, user_id: @upload_history.user_id, workflow_transition_id: @upload_history.workflow_transition_id }
    assert_redirected_to upload_history_path(assigns(:upload_history))
  end

  test "should destroy upload_history" do
    assert_difference('UploadHistory.count', -1) do
      delete :destroy, id: @upload_history
    end

    assert_redirected_to upload_histories_path
  end
end
