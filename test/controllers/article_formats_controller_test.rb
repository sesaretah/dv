require 'test_helper'

class ArticleFormatsControllerTest < ActionController::TestCase
  setup do
    @article_format = article_formats(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:article_formats)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article_format" do
    assert_difference('ArticleFormat.count') do
      post :create, article_format: { description: @article_format.description, title: @article_format.title }
    end

    assert_redirected_to article_format_path(assigns(:article_format))
  end

  test "should show article_format" do
    get :show, id: @article_format
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @article_format
    assert_response :success
  end

  test "should update article_format" do
    patch :update, id: @article_format, article_format: { description: @article_format.description, title: @article_format.title }
    assert_redirected_to article_format_path(assigns(:article_format))
  end

  test "should destroy article_format" do
    assert_difference('ArticleFormat.count', -1) do
      delete :destroy, id: @article_format
    end

    assert_redirected_to article_formats_path
  end
end
