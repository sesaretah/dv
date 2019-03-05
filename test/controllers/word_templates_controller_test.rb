require 'test_helper'

class WordTemplatesControllerTest < ActionController::TestCase
  setup do
    @word_template = word_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:word_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create word_template" do
    assert_difference('WordTemplate.count') do
      post :create, word_template: { title: @word_template.title, workflow_id: @word_template.workflow_id }
    end

    assert_redirected_to word_template_path(assigns(:word_template))
  end

  test "should show word_template" do
    get :show, id: @word_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @word_template
    assert_response :success
  end

  test "should update word_template" do
    patch :update, id: @word_template, word_template: { title: @word_template.title, workflow_id: @word_template.workflow_id }
    assert_redirected_to word_template_path(assigns(:word_template))
  end

  test "should destroy word_template" do
    assert_difference('WordTemplate.count', -1) do
      delete :destroy, id: @word_template
    end

    assert_redirected_to word_templates_path
  end
end
