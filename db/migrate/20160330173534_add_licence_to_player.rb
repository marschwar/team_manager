class AddLicenceToPlayer < ActiveRecord::Migration
  def change
    add_column :players, :licence, :string
  end
end
