class RentalEquipment < ActiveRecord::Base
  TYPES = ['Helmet', 'Pad']

  belongs_to :player

  validates_presence_of :type, :rental_date

  scope :active, -> {where(return_date: nil)}
  scope :of_team, -> (team) { joins(:player).where('players.team_id = ? or (players.birthday >= ? and players.birthday <= ?)', team, team.first_day, team.last_day) }
end
