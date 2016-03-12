class TeamEquipment < ActiveRecord::Base
  validates_presence_of :team_id

  belongs_to :team

  scope :of_team, -> (team) {where team_id: team}

end
