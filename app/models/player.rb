class Player < ActiveRecord::Base
	OFFENSE_POSITIONS = %w(QB RB WR OL TE)
	DEFENSE_POSITIONS = %w(DL LB CB S)
	POSITIONS = OFFENSE_POSITIONS + DEFENSE_POSITIONS
	YEAR_CLASSES = %w(Sr Jr So Fr)

	has_many :contacts

	scope :of_team, -> (team) { where('team_id = ? or (birthday >= ? and birthday <= ?)', team, team.first_day, team.last_day) }
	scope :list, -> (ids) {where(id: ids).order([:first_name, :last_name])}

	def team
		Team.find team_id if team_id
	end

	def actual_team
		team || Team.any_with_birthday(birthday) 
	end

	def actual_team_name
		actual_team.try(:name)
	end

	def full_name
		"#{first_name} #{last_name}"
	end

	def team_overwritten
		!!team_id
	end

	# In Ermangelung eines besseren Names. Dies ist der Jahrgang
	def year_class
		if birthday
			year_index = birthday.year - actual_team.year_from
			YEAR_CLASSES[year_index] if year_index.between?(0, 3)
		end
	end

end
