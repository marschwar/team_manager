class AddPantsSizeToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :pants_size, :string
  end
end
