class Team < ActiveRecord::Base

	has_many :events

	validates_presence_of :name, :year_from, :year_until
	
	delegate :practices, to: :events

	scope :for_birthday, -> (date) { where('year_from <= ? and year_until >= ?', date.year, date.year) }

	def first_day
		Date.new year_from, 1, 1
	end

	def last_day
		Date.new year_until, 12, 31
	end

end
