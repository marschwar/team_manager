class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
    	t.references :team, null: false
      t.string :type, null: false
      t.string :name
      t.date :event_date, null: false

      t.timestamps null: false
    end
  end
end
