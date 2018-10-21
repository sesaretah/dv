require 'test_helper'

class SpeakingsControllerTest < ActionController::TestCase
  setup do
    @speaking = speakings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:speakings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create speaking" do
    assert_difference('Speaking.count') do
      post :create, speaking: { article_id: @speaking.article_id, language_id: @speaking.language_id }
    end

    assert_redirected_to speaking_path(assigns(:speaking))
  end

  test "should show speaking" do
    get :show, id: @speaking
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @speaking
    assert_response :success
  end

  test "should update speaking" do
    patch :update, id: @speaking, speaking: { article_id: @speaking.article_id, language_id: @speaking.language_id }
    assert_redirected_to speaking_path(assigns(:speaking))
  end

  test "should destroy speaking" do
    assert_difference('Speaking.count', -1) do
      delete :destroy, id: @speaking
    end

    assert_redirected_to speakings_path
  end
end
