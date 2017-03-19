class CreateMemberStatuses < ActiveRecord::Migration
  def change
    create_table :member_statuses do |t|
      t.references :player, null: false
      t.boolean :rental_equipment, null: false

      t.timestamps null: false
    end
  end
end
