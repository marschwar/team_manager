class GamePantsController < ApplicationController
  include TeamScoped

  load_and_authorize_resource

  def index
    @pants = GamePants.new team_id: @team
    @all_pants = GamePants.of_team(@team).to_a.sort
  end

  def create
    @pants = GamePants.new game_pants_params
    @pants.team = @team
    if @pants.save
      redirect_to team_game_pants_index_path(@team)
    else
      flash[:error] = @pants.errors.full_messages.first
      @all_pants = GamePants.of_team(@team)
      render :index
    end
  end

  def edit
  end

  def update
    @game_pants.update game_pants_params
    if @game_pants.save
      redirect_to team_game_pants_index_path(@team)
    else
      render :edit
    end
  end

private

  def game_pants_params
    params.require(:game_pants).permit(:size, :count)
  end

end
