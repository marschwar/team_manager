class CreateTeamEquipments < ActiveRecord::Migration
  def change
    create_table :team_equipments do |t|
      t.references :team
      t.string :type
      t.string :size
      t.integer :number

      t.timestamps null: false
    end
  end
end
