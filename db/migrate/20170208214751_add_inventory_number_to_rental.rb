class AddInventoryNumberToRental < ActiveRecord::Migration
  def change
    add_column :rentals, :inventory_number, :string
  end
end
