class AddAuthTokenToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :auth_token, :string, null: false
    add_index :users, :auth_token, unique: true
  end
end
