class CreateTeams < ActiveRecord::Migration
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :year_from
      t.integer :year_until

      t.timestamps null: false
    end
  end
end
