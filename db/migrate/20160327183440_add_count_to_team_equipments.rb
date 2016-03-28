class AddCountToTeamEquipments < ActiveRecord::Migration
  def change
    add_column :team_equipments, :count, :integer
  end
end
