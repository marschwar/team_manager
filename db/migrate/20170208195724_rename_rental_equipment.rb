class RenameRentalEquipment < ActiveRecord::Migration
  def change
    rename_table :rental_equipments, :rentals
  end
end
