require 'test_helper'

class ContentTemplatesControllerTest < ActionController::TestCase
  setup do
    @content_template = content_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:content_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create content_template" do
    assert_difference('ContentTemplate.count') do
      post :create, content_template: { content: @content_template.content, title: @content_template.title, user_id: @content_template.user_id }
    end

    assert_redirected_to content_template_path(assigns(:content_template))
  end

  test "should show content_template" do
    get :show, id: @content_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @content_template
    assert_response :success
  end

  test "should update content_template" do
    patch :update, id: @content_template, content_template: { content: @content_template.content, title: @content_template.title, user_id: @content_template.user_id }
    assert_redirected_to content_template_path(assigns(:content_template))
  end

  test "should destroy content_template" do
    assert_difference('ContentTemplate.count', -1) do
      delete :destroy, id: @content_template
    end

    assert_redirected_to content_templates_path
  end
end
