class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :year_from, null: false
      t.integer :year_until, null: false

      t.timestamps null: false
    end
  end
end
