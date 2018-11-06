require 'test_helper'

class AccessControlsControllerTest < ActionController::TestCase
  setup do
    @access_control = access_controls(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:access_controls)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create access_control" do
    assert_difference('AccessControl.count') do
      post :create, access_control: { alter_article_areas: @access_control.alter_article_areas, alter_article_events: @access_control.alter_article_events, alter_article_formats: @access_control.alter_article_formats, alter_article_relation_types: @access_control.alter_article_relation_types, alter_article_sources: @access_control.alter_article_sources, alter_article_types: @access_control.alter_article_types, alter_duties: @access_control.alter_duties, alter_keywords: @access_control.alter_keywords, alter_languages: @access_control.alter_languages, alter_profiles: @access_control.alter_profiles, alter_roles: @access_control.alter_roles, alter_title_types: @access_control.alter_title_types, create_workflow: @access_control.create_workflow, role_id: @access_control.role_id, user_id: @access_control.user_id, view_article_logs: @access_control.view_article_logs, view_unrelated_articles: @access_control.view_unrelated_articles, view_workflow_transactions: @access_control.view_workflow_transactions }
    end

    assert_redirected_to access_control_path(assigns(:access_control))
  end

  test "should show access_control" do
    get :show, id: @access_control
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @access_control
    assert_response :success
  end

  test "should update access_control" do
    patch :update, id: @access_control, access_control: { alter_article_areas: @access_control.alter_article_areas, alter_article_events: @access_control.alter_article_events, alter_article_formats: @access_control.alter_article_formats, alter_article_relation_types: @access_control.alter_article_relation_types, alter_article_sources: @access_control.alter_article_sources, alter_article_types: @access_control.alter_article_types, alter_duties: @access_control.alter_duties, alter_keywords: @access_control.alter_keywords, alter_languages: @access_control.alter_languages, alter_profiles: @access_control.alter_profiles, alter_roles: @access_control.alter_roles, alter_title_types: @access_control.alter_title_types, create_workflow: @access_control.create_workflow, role_id: @access_control.role_id, user_id: @access_control.user_id, view_article_logs: @access_control.view_article_logs, view_unrelated_articles: @access_control.view_unrelated_articles, view_workflow_transactions: @access_control.view_workflow_transactions }
    assert_redirected_to access_control_path(assigns(:access_control))
  end

  test "should destroy access_control" do
    assert_difference('AccessControl.count', -1) do
      delete :destroy, id: @access_control
    end

    assert_redirected_to access_controls_path
  end
end
