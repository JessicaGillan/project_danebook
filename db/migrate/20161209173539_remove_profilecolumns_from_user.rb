class RemoveProfilecolumnsFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :birthday
    remove_column :users, :gender
  end
end
