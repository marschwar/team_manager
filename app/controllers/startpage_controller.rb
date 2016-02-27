class StartpageController < ApplicationController
  def show
     redirect_to players_path if @current_user
  end
end