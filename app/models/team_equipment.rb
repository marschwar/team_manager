class TeamEquipment < ApplicationRecord
  SIZES = %w(XXS XS S M L XL XXL XXXL)

  validates_presence_of :team_id

  belongs_to :team

  scope :of_team, -> (team) {where team_id: team}

end
