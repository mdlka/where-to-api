class CreatePlaces < ActiveRecord::Migration[8.0]
  def change
    create_table :places do |t|
      t.string :name, null: false
      t.text :description, null: false, default: ""
      t.float :latitude, null: false
      t.float :longitude, null: false

      t.timestamps
    end
  end
end
