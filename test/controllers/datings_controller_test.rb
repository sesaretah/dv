require 'test_helper'

class DatingsControllerTest < ActionController::TestCase
  setup do
    @dating = datings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:datings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dating" do
    assert_difference('Dating.count') do
      post :create, dating: { article_event_id: @dating.article_event_id, article_id: @dating.article_id, event_date: @dating.event_date }
    end

    assert_redirected_to dating_path(assigns(:dating))
  end

  test "should show dating" do
    get :show, id: @dating
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dating
    assert_response :success
  end

  test "should update dating" do
    patch :update, id: @dating, dating: { article_event_id: @dating.article_event_id, article_id: @dating.article_id, event_date: @dating.event_date }
    assert_redirected_to dating_path(assigns(:dating))
  end

  test "should destroy dating" do
    assert_difference('Dating.count', -1) do
      delete :destroy, id: @dating
    end

    assert_redirected_to datings_path
  end
end
