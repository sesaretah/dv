require 'test_helper'

class ArticleAreasControllerTest < ActionController::TestCase
  setup do
    @article_area = article_areas(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:article_areas)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article_area" do
    assert_difference('ArticleArea.count') do
      post :create, article_area: { description: @article_area.description, title: @article_area.title }
    end

    assert_redirected_to article_area_path(assigns(:article_area))
  end

  test "should show article_area" do
    get :show, id: @article_area
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @article_area
    assert_response :success
  end

  test "should update article_area" do
    patch :update, id: @article_area, article_area: { description: @article_area.description, title: @article_area.title }
    assert_redirected_to article_area_path(assigns(:article_area))
  end

  test "should destroy article_area" do
    assert_difference('ArticleArea.count', -1) do
      delete :destroy, id: @article_area
    end

    assert_redirected_to article_areas_path
  end
end
