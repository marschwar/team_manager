class CreateRentalEquipment < ActiveRecord::Migration
  def change
    create_table :rental_equipments do |t|
      t.string :inventory_number, null: false
      t.string :brand
      t.string :size
      t.boolean :active, null: false, default: true

      t.timestamps null: false
    end
    add_index :rental_equipments, [:inventory_number], unique: true
  end
end
