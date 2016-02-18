class Event < ActiveRecord::Base
	belongs_to :team

	has_many :participations

  scope :practices, -> {where(type: 'Practice')}
  scope :for_team, -> (team) {where(team: team)}
  scope :by_date, -> {order(:event_date)}
end
