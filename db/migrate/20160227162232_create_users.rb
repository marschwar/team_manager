class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :common_name, null: false
      t.string :social_id
      t.string :email
      t.string :role, null: false, default: :user

      t.timestamps
    end
  end
end
