require 'test_helper'

class ArticleRelationTypesControllerTest < ActionController::TestCase
  setup do
    @article_relation_type = article_relation_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:article_relation_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article_relation_type" do
    assert_difference('ArticleRelationType.count') do
      post :create, article_relation_type: { description: @article_relation_type.description, title: @article_relation_type.title }
    end

    assert_redirected_to article_relation_type_path(assigns(:article_relation_type))
  end

  test "should show article_relation_type" do
    get :show, id: @article_relation_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @article_relation_type
    assert_response :success
  end

  test "should update article_relation_type" do
    patch :update, id: @article_relation_type, article_relation_type: { description: @article_relation_type.description, title: @article_relation_type.title }
    assert_redirected_to article_relation_type_path(assigns(:article_relation_type))
  end

  test "should destroy article_relation_type" do
    assert_difference('ArticleRelationType.count', -1) do
      delete :destroy, id: @article_relation_type
    end

    assert_redirected_to article_relation_types_path
  end
end
