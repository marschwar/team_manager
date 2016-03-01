class StartpageController < ApplicationController
  def show
     redirect_to players_path if can? :index, Player
  end
end