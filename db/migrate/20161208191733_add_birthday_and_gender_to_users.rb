class AddBirthdayAndGenderToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :birthday, :date, null: false
    add_column :users, :gender, :integer
  end
end
