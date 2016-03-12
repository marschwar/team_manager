class GameJersey < TeamEquipment
  validates_presence_of :number
  validates :number, numericality: { only_integer: true, greater_than_or_equal_to: 1, lesa_than_or_equal_to: 99 }
  validates_uniqueness_of :number, scope: :team_id

  scope :sorted, -> {order :number}

  def player
    @player ||= Player.of_team(team).find_by(number: number)
  end
end
