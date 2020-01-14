require 'test_helper'

class ProfileGroupsControllerTest < ActionController::TestCase
  setup do
    @profile_group = profile_groups(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:profile_groups)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create profile_group" do
    assert_difference('ProfileGroup.count') do
      post :create, profile_group: { description: @profile_group.description, title: @profile_group.title }
    end

    assert_redirected_to profile_group_path(assigns(:profile_group))
  end

  test "should show profile_group" do
    get :show, id: @profile_group
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @profile_group
    assert_response :success
  end

  test "should update profile_group" do
    patch :update, id: @profile_group, profile_group: { description: @profile_group.description, title: @profile_group.title }
    assert_redirected_to profile_group_path(assigns(:profile_group))
  end

  test "should destroy profile_group" do
    assert_difference('ProfileGroup.count', -1) do
      delete :destroy, id: @profile_group
    end

    assert_redirected_to profile_groups_path
  end
end
