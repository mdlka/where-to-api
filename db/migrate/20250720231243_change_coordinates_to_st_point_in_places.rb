class ChangeCoordinatesToStPointInPlaces < ActiveRecord::Migration[8.0]
  def change
    change_table :places do |t|
      t.st_point :location, geographic: true, null: false

      t.remove :latitude
      t.remove :longitude
    end
  end
end
