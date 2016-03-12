class TeamEquipmentsController < ApplicationController
  include TeamScoped

  load_and_authorize_resource

  def index
    equipment = TeamEquipment.of_team(@team).to_a
    @jerseys = equipment.select{|e| e.type == 'GameJersey'}.group_by(&:size)
    @jersey_count = equipment.count{|e| e.type == 'GameJersey'}
    @pants = equipment.select{|e| e.type == 'GamePants'}.group_by(&:size)
    @pants_count = equipment.count{|e| e.type == 'GamePants'}
  end
end
