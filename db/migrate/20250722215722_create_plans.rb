class CreatePlans < ActiveRecord::Migration[8.0]
  def change
    create_table :plans do |t|
      t.string :title, null: false
      t.boolean :is_active, null: false

      t.timestamps
    end
  end
end
