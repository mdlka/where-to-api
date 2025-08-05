class AddUserAndNameToPlanPlaces < ActiveRecord::Migration[8.0]
  def change
    add_reference :plan_places, :user, null: false, foreign_key: true
    add_column :plan_places, :name, :string, null: false
  end
end
