require 'test_helper'

class VotingsControllerTest < ActionController::TestCase
  setup do
    @voting = votings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:votings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create voting" do
    assert_difference('Voting.count') do
      post :create, voting: { deadline: @voting.deadline, votable_id: @voting.votable_id, votable_type: @voting.votable_type, voting_type: @voting.voting_type }
    end

    assert_redirected_to voting_path(assigns(:voting))
  end

  test "should show voting" do
    get :show, id: @voting
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @voting
    assert_response :success
  end

  test "should update voting" do
    patch :update, id: @voting, voting: { deadline: @voting.deadline, votable_id: @voting.votable_id, votable_type: @voting.votable_type, voting_type: @voting.voting_type }
    assert_redirected_to voting_path(assigns(:voting))
  end

  test "should destroy voting" do
    assert_difference('Voting.count', -1) do
      delete :destroy, id: @voting
    end

    assert_redirected_to votings_path
  end
end
