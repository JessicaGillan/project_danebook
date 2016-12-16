class CreatePhotos < ActiveRecord::Migration[5.0]
  def change
    create_table :photos do |t|
      t.attachment :photo
      t.integer :owner_id, null: false

      t.timestamps
    end

    add_index :photos, :owner_id
  end
end
