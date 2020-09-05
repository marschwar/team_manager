class StartpageController < ApplicationController

  skip_before_action :redirect_to_startpage, only: [:show]

  def show
    if current_team
      redirect_to team_players_path(current_team) if can? :index, Player
    else
      redirect_to players_path if can? :index, Player
    end
  end
end