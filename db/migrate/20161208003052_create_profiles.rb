class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.references :user, foreign_key: true
      t.date :birthday
      t.string :college
      t.string :hometown
      t.string :current_location
      t.string :phone
      t.text :about_me
      t.text :tagline

      t.timestamps
    end
  end
end
