class Rental < ActiveRecord::Base
  TYPES = ['Helmet', 'Pad']

  belongs_to :player

  validates_presence_of :type, :rental_date
  validates :inventory_number,
    format: { with: RentalEquipment::FORMAT, message: "muss das Format [HP]1234 haben" },
    if: "inventory_number.present?"

  scope :active, -> {where(return_date: nil)}
  scope :of_team, -> (team) { joins(:player).where('players.team_id = ? or (players.birthday >= ? and players.birthday <= ?)', team, team.first_day, team.last_day) }
end
