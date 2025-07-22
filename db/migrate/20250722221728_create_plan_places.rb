class CreatePlanPlaces < ActiveRecord::Migration[8.0]
  def change
    create_table :plan_places do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :place, null: false, foreign_key: true

      t.timestamps
    end
  end
end
