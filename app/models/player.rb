class Player < ActiveRecord::Base

	scope :of_team, -> (team) { where('team_id = ? or (birthday >= ? and birthday <= ?)', team, team.first_day, team.last_day) }

	def team
		Team.find team_id if team_id
	end

	def actual_team
		team || Team.for_birthday(birthday).first 
	end

private 
end
