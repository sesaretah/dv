require 'test_helper'

class PublishSourcesControllerTest < ActionController::TestCase
  setup do
    @publish_source = publish_sources(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:publish_sources)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create publish_source" do
    assert_difference('PublishSource.count') do
      post :create, publish_source: { description: @publish_source.description, publisher_id: @publish_source.publisher_id, title: @publish_source.title }
    end

    assert_redirected_to publish_source_path(assigns(:publish_source))
  end

  test "should show publish_source" do
    get :show, id: @publish_source
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @publish_source
    assert_response :success
  end

  test "should update publish_source" do
    patch :update, id: @publish_source, publish_source: { description: @publish_source.description, publisher_id: @publish_source.publisher_id, title: @publish_source.title }
    assert_redirected_to publish_source_path(assigns(:publish_source))
  end

  test "should destroy publish_source" do
    assert_difference('PublishSource.count', -1) do
      delete :destroy, id: @publish_source
    end

    assert_redirected_to publish_sources_path
  end
end
