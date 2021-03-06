require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  setup do
    with_user :manager
    @player = players(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:players)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create player" do
    assert_difference('Player.count') do
      post :create, params: { player: { first_name: 'first', last_name: 'last' } }
    end

    assert_redirected_to player_path(assigns(:player))
  end

  test "should show player" do
    get :show, params: {id: @player}
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: {id: @player}
    assert_response :success
  end

  test "should update player" do
    patch :update, params: {id: @player, player: { first_name: 'first', last_name: 'last' }}
    assert_redirected_to player_path(assigns(:player))
  end

  test "should destroy player" do
    with_user :admin
    assert_difference('Player.count', -1) do
      delete :destroy, params: {id: @player}
    end

    assert_redirected_to team_players_path(Team.first)
  end
end
