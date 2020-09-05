require 'test_helper'

class TeamsControllerTest < ActionController::TestCase

  [:user, :manager, :admin].each do |role|
    setup do
      with_user role
      @team = teams(:one)
    end

    test "should get index as #{role}" do
      get :index
      assert_response :success
      assert_not_nil assigns(:teams)
    end

    test "should get new as #{role}" do
      get :new
      assert_response :success
    end

    test "should create team as #{role}" do
      assert_difference('Team.count') do
        post :create, params: {
          team: { name: @team.name, year_from: 2000, year_until: 2003 }
        }
      end

      assert_redirected_to team_path(assigns(:team))
    end

    test "should show team as #{role}" do
      get :show, params: { id: @team.id }
      assert_response :success
    end

    test "should get edit as #{role}" do
      get :edit, params: { id: @team }
      assert_response :success
    end

    test "should update team as #{role}" do
      patch :update, params: {
        id: @team, 
        team: { name: @team.name }
      }
      assert_redirected_to team_path(assigns(:team))
    end

    test "should destroy team as #{role}" do
      assert_difference('Team.count', -1) do
        delete :destroy, params: { id: @team }
      end

      assert_redirected_to teams_path
    end

  end

end
