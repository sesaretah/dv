require 'test_helper'

class TypingsControllerTest < ActionController::TestCase
  setup do
    @typing = typings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:typings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create typing" do
    assert_difference('Typing.count') do
      post :create, typing: { article_id: @typing.article_id, article_type_id: @typing.article_type_id }
    end

    assert_redirected_to typing_path(assigns(:typing))
  end

  test "should show typing" do
    get :show, id: @typing
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @typing
    assert_response :success
  end

  test "should update typing" do
    patch :update, id: @typing, typing: { article_id: @typing.article_id, article_type_id: @typing.article_type_id }
    assert_redirected_to typing_path(assigns(:typing))
  end

  test "should destroy typing" do
    assert_difference('Typing.count', -1) do
      delete :destroy, id: @typing
    end

    assert_redirected_to typings_path
  end
end
