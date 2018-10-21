require 'test_helper'

class TitlingsControllerTest < ActionController::TestCase
  setup do
    @titling = titlings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:titlings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create titling" do
    assert_difference('Titling.count') do
      post :create, titling: { article_id: @titling.article_id, status: @titling.status, title_type_id: @titling.title_type_id }
    end

    assert_redirected_to titling_path(assigns(:titling))
  end

  test "should show titling" do
    get :show, id: @titling
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @titling
    assert_response :success
  end

  test "should update titling" do
    patch :update, id: @titling, titling: { article_id: @titling.article_id, status: @titling.status, title_type_id: @titling.title_type_id }
    assert_redirected_to titling_path(assigns(:titling))
  end

  test "should destroy titling" do
    assert_difference('Titling.count', -1) do
      delete :destroy, id: @titling
    end

    assert_redirected_to titlings_path
  end
end
