class AddColumnsToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :first_name, :string, null: false
    add_column :profiles, :last_name, :string, null: false
    add_column :profiles, :birthday, :date
    add_column :profiles, :gender, :integer
  end
end
