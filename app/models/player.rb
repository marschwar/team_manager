class Player < ActiveRecord::Base
	OFFENSE_POSITIONS = %w(QB RB WR OL TE)
	DEFENSE_POSITIONS = %w(DL LB CB S)
	POSITIONS = OFFENSE_POSITIONS + DEFENSE_POSITIONS
	YEAR_CLASSES = %w(Sr Jr So Fr)

	has_many :participations, dependent: :destroy
	has_many :contacts, dependent: :destroy
	has_many :rental_equipments, dependent: :destroy

	scope :of_team, -> (team) { where('team_id = ? or (birthday >= ? and birthday <= ?)', team, team.first_day, team.last_day) }
	scope :active, -> {where(active: true)}
	scope :list, -> (ids) {where(id: ids)}
	scope :sorted, -> {order([:last_name, :first_name])}

	def team
		Team.find team_id if team_id
	end

	def actual_team
		@actual_team ||= (team || Team.any_with_birthday(birthday))
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
		if birthday && actual_team
			year_index = birthday.year - actual_team.year_from
			YEAR_CLASSES[year_index] if year_index.between?(0, 3)
		end
	end

end
