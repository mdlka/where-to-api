class RemovePlaceIdFromPlanPlaces < ActiveRecord::Migration[8.0]
  def change
    remove_index :plan_places, :place_id
    remove_column :plan_places, :place_id, :bigint
  end
end
