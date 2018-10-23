require 'test_helper'

class OriginatingsControllerTest < ActionController::TestCase
  setup do
    @originating = originatings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:originatings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create originating" do
    assert_difference('Originating.count') do
      post :create, originating: { article_id: @originating.article_id, article_source_id: @originating.article_source_id }
    end

    assert_redirected_to originating_path(assigns(:originating))
  end

  test "should show originating" do
    get :show, id: @originating
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @originating
    assert_response :success
  end

  test "should update originating" do
    patch :update, id: @originating, originating: { article_id: @originating.article_id, article_source_id: @originating.article_source_id }
    assert_redirected_to originating_path(assigns(:originating))
  end

  test "should destroy originating" do
    assert_difference('Originating.count', -1) do
      delete :destroy, id: @originating
    end

    assert_redirected_to originatings_path
  end
end
