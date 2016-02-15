class ApplicationController < ActionController::Base
	include CurrentTeam

  before_action :load_teams

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  def load_teams
  	@all_teams = Team.all
  end
end
