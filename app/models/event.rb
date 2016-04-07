class Event < ActiveRecord::Base
	belongs_to :team

	has_many :participations

  scope :for_team, -> (team) {where(team: team)}
  scope :by_date, -> {order(:event_date)}
  scope :after, -> (date) { where('event_date >= ?', date) }
end
