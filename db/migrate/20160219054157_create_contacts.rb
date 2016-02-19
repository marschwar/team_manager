class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.references :player, null: false
      t.string :email, null: false
      t.string :description

      t.timestamps null: false
    end
  end
end
