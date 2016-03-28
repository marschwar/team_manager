class TeamEquipmentsController < ApplicationController
  include TeamScoped

  load_and_authorize_resource

  def index
    equipment = TeamEquipment.of_team(@team).to_a
    @jerseys = TeamEquipment::SIZES.map do |size|
      {
        size: size, 
        count: equipment.count {|e| e.type == 'GameJersey' && e.size == size},
        in_use: equipment.count {|e| e.type == 'GameJersey' && e.size == size && Player.of_team(@team).with_number(e.number).exists?}
      }
    end
    @jersey_count = equipment.count{|e| e.type == 'GameJersey'}
    @jersey_in_use_count = @jerseys.sum{|e| e[:in_use]}
    @pants = equipment.select{|e| e.type == 'GamePants'}
    @pants = TeamEquipment::SIZES.map do |size|
      {
        size: size, 
        count: equipment.find {|e| e.type == 'GamePants' && e.size == size}.try(:count) || 0,
        in_use: Player.of_team(@team).where(pants_size: size).count
      }
    end
    @pants_count = equipment.count{|e| e.type == 'GamePants'}
    @pants_in_use_count = @pants.sum{|e| e[:in_use]}
  end
end
