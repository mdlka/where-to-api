class AddLocationToPlanPlaces < ActiveRecord::Migration[8.0]
  def change
    change_table :plan_places do |t|
      t.st_point :location, geographic: true, null: false
    end
  end
end
