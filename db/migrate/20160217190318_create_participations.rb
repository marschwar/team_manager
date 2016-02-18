class CreateParticipations < ActiveRecord::Migration
  def change
    create_table :participations do |t|
    	t.references :event, null: false
    	t.references :player, null: false
    	t.boolean :participated, null: false, default: false

      t.timestamps null: false
    end
    add_index :participations, [:event_id, :player_id], unique: true
  end
end
