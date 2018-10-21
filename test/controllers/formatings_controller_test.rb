require 'test_helper'

class FormatingsControllerTest < ActionController::TestCase
  setup do
    @formating = formatings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:formatings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create formating" do
    assert_difference('Formating.count') do
      post :create, formating: { article_format_id: @formating.article_format_id, article_id: @formating.article_id }
    end

    assert_redirected_to formating_path(assigns(:formating))
  end

  test "should show formating" do
    get :show, id: @formating
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @formating
    assert_response :success
  end

  test "should update formating" do
    patch :update, id: @formating, formating: { article_format_id: @formating.article_format_id, article_id: @formating.article_id }
    assert_redirected_to formating_path(assigns(:formating))
  end

  test "should destroy formating" do
    assert_difference('Formating.count', -1) do
      delete :destroy, id: @formating
    end

    assert_redirected_to formatings_path
  end
end
