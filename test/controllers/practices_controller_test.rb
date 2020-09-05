require 'test_helper'

class PracticesControllerTest < ActionController::TestCase
  setup do
    with_user :manager
    @event = events(:one)
  end

  def participation_params
    {}.tap do | par |
      Player.of_team(@event.team).each { |player| par["#{player.id}"] = {'participated': '0'} }
    end
  end

  test "should get index" do
    get :index, params: {team_id: @event.team_id}
    assert_response :success
    assert_not_nil assigns(:events)
  end

  test "should get new" do
    get :new, params: {team_id: @event.team_id}
    assert_response :success
  end

  test "should create event" do
    assert_difference('Event.count') do
      post :create, params: {
        team_id: @event.team_id,
        practice: { event_date: @event.event_date, name: @event.name, type: @event.type },
        participation: participation_params
      }
    end

    assert_redirected_to team_event_path(@event.team, assigns(:event))
  end

  test "should show event" do
    get :show, params: {team_id: @event.team_id, id: @event}
    assert_response :success
  end

  test "should get edit" do
    get :edit, params: {team_id: @event.team_id, id: @event}
    assert_response :success
  end

  test "should update event" do
    patch :update, params: {
      team_id: @event.team_id,
      id: @event,
      practice: { event_date: @event.event_date, name: @event.name, type: @event.type },
      participation: participation_params
    }

    assert_redirected_to team_practice_path(@event.team, assigns(:event))
  end

  test "should destroy event" do
    assert_difference('Event.count', -1) do
      delete :destroy, params: {team_id: @event.team_id, id: @event}
    end

    assert_redirected_to team_events_path(@event.team)
  end
end
