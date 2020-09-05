class AddNameToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :phone, :string
  end

  def up
	change_column :contacts, :email, :string, null: true  	
  end
end
