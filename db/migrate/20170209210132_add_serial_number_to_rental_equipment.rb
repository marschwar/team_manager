class AddSerialNumberToRentalEquipment < ActiveRecord::Migration
  def change
    add_column :rental_equipments, :serial_number, :string
  end
end
