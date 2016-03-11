class CreateRentalEquipments < ActiveRecord::Migration
  def change
    create_table :rental_equipments do |t|
      t.references :player, null: false
      t.string :type, null: false
      t.string :brand
      t.string :size
      t.date :rental_date, null: false
      t.date :return_date

      t.timestamps null: false
    end
  end
end
