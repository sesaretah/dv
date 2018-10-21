require 'test_helper'

class TitleTypesControllerTest < ActionController::TestCase
  setup do
    @title_type = title_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:title_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create title_type" do
    assert_difference('TitleType.count') do
      post :create, title_type: { description: @title_type.description, title: @title_type.title }
    end

    assert_redirected_to title_type_path(assigns(:title_type))
  end

  test "should show title_type" do
    get :show, id: @title_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @title_type
    assert_response :success
  end

  test "should update title_type" do
    patch :update, id: @title_type, title_type: { description: @title_type.description, title: @title_type.title }
    assert_redirected_to title_type_path(assigns(:title_type))
  end

  test "should destroy title_type" do
    assert_difference('TitleType.count', -1) do
      delete :destroy, id: @title_type
    end

    assert_redirected_to title_types_path
  end
end
