class Player < ActiveRecord::Base
	OFFENSE_POSITIONS = %w(QB RB WR OL TE)
	DEFENSE_POSITIONS = %w(DL LB CB S)
	POSITIONS = OFFENSE_POSITIONS + DEFENSE_POSITIONS
	YEAR_CLASSES = %w(Sr Jr So Fr)

	has_many :participations, dependent: :destroy
	has_many :contacts, dependent: :destroy
	has_many :rentals, dependent: :destroy
	has_one :member_status, dependent: :destroy

	scope :of_team, -> (team) { where('team_id = ? or (team_id is null and birthday >= ? and birthday <= ?)', team, team.first_day, team.last_day) }
	scope :with_number, -> (number) {where(number: number)}
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

	def active_rental?
		rentals.any? { |r| r.return_date.blank? }
	end

	def invalid_rental_status?
		member_status.present? &&
			member_status.rental_equipment != active_rental?
	end

	def matches?(other_last_name, other_first_name, other_birthday)
		matches_last = last_name && last_name.downcase == other_last_name.try(:downcase)
		matches_first = first_name && first_name.downcase == other_first_name.try(:downcase)
		matches_birthday = birthday && birthday == other_birthday

		(matches_first && matches_first) ||
		(matches_first && matches_birthday) ||
		(matches_last && matches_birthday)
	end

end
