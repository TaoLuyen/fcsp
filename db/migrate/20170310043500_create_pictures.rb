class CreatePictures < ActiveRecord::Migration[5.0]
  def change
    create_table :pictures do |t|
      t.integer :pictureable_id
      t.string :pictureable_type
      t.string :picture
      t.text :caption

      t.timestamps
    end
  end
end
