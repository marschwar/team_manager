class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :first_name, null:false
      t.string :last_name
      t.date :birthday
      t.integer :team_id

      t.timestamps null: false
    end
  end
end
