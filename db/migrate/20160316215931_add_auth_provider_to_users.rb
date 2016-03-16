class AddAuthProviderToUsers < ActiveRecord::Migration
  def change
    add_column :users, :auth_provider, :string

    User.update_all auth_provider: 'facebook'
  end
end
