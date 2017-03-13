class CreatePermissions < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions do |t|
      t.string :entry
      t.hash :optional

      t.timestamps
    end
  end
end
