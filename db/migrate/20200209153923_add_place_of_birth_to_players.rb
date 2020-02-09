class AddPlaceOfBirthToPlayers < ActiveRecord::Migration
  def change
    add_column :players, :place_of_birth, :string
    add_column :players, :member_since, :date
  end
end
