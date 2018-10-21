require 'test_helper'

class ArticleEventsControllerTest < ActionController::TestCase
  setup do
    @article_event = article_events(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:article_events)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create article_event" do
    assert_difference('ArticleEvent.count') do
      post :create, article_event: { description: @article_event.description, title: @article_event.title }
    end

    assert_redirected_to article_event_path(assigns(:article_event))
  end

  test "should show article_event" do
    get :show, id: @article_event
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @article_event
    assert_response :success
  end

  test "should update article_event" do
    patch :update, id: @article_event, article_event: { description: @article_event.description, title: @article_event.title }
    assert_redirected_to article_event_path(assigns(:article_event))
  end

  test "should destroy article_event" do
    assert_difference('ArticleEvent.count', -1) do
      delete :destroy, id: @article_event
    end

    assert_redirected_to article_events_path
  end
end
