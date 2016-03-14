class StartpageController < ApplicationController
  def show
    if current_team
      redirect_to team_players_path(current_team) if can? :index, Player
    else
      redirect_to players_path if can? :index, Player
    end
  end
end