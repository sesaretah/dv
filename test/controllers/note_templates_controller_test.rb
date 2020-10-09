require 'test_helper'

class NoteTemplatesControllerTest < ActionController::TestCase
  setup do
    @note_template = note_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:note_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create note_template" do
    assert_difference('NoteTemplate.count') do
      post :create, note_template: { title: @note_template.title, user_id: @note_template.user_id }
    end

    assert_redirected_to note_template_path(assigns(:note_template))
  end

  test "should show note_template" do
    get :show, id: @note_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @note_template
    assert_response :success
  end

  test "should update note_template" do
    patch :update, id: @note_template, note_template: { title: @note_template.title, user_id: @note_template.user_id }
    assert_redirected_to note_template_path(assigns(:note_template))
  end

  test "should destroy note_template" do
    assert_difference('NoteTemplate.count', -1) do
      delete :destroy, id: @note_template
    end

    assert_redirected_to note_templates_path
  end
end
