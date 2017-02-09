class DropActiveFlagOnRentals < ActiveRecord::Migration
  def change
    remove_column :rentals, :active
  end
end
