class Team < ActiveRecord::Base

	has_many :events

	validates_presence_of :name, :year_from, :year_until
	
	delegate :practices, to: :events

	scope :for_birthday, -> (date) { where('year_from <= ? and year_until >= ?', date.year, date.year) }

	def self.any_with_birthday(birthday)
		self.for_birthday(birthday).first if birthday
	end

	def first_day
		year_from ? Date.new(year_from, 1, 1) : Date.new(1900, 1, 1)
	end

	def last_day
		year_until ? Date.new(year_until, 12, 31) : Date.new
	end

	def players
		@players ||= Player.of_team self
	end
end
