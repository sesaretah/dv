require 'test_helper'

class ArticleHistoriesControllerTest < ActionController::TestCase
  setup do
    @article_history = article_histories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:article_histories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article_history" do
    assert_difference('ArticleHistory.count') do
      post :create, article_history: { abstract: @article_history.abstract, content: @article_history.content, document_contents: @article_history.document_contents, title: @article_history.title, url: @article_history.url }
    end

    assert_redirected_to article_history_path(assigns(:article_history))
  end

  test "should show article_history" do
    get :show, id: @article_history
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @article_history
    assert_response :success
  end

  test "should update article_history" do
    patch :update, id: @article_history, article_history: { abstract: @article_history.abstract, content: @article_history.content, document_contents: @article_history.document_contents, title: @article_history.title, url: @article_history.url }
    assert_redirected_to article_history_path(assigns(:article_history))
  end

  test "should destroy article_history" do
    assert_difference('ArticleHistory.count', -1) do
      delete :destroy, id: @article_history
    end

    assert_redirected_to article_histories_path
  end
end
