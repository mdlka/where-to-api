class AddCascadeDeleteToPlans < ActiveRecord::Migration[8.0]
  def change
    remove_foreign_key :plan_members, :plans
    remove_foreign_key :plan_places, :plans

    add_foreign_key :plan_members, :plans, on_delete: :cascade
    add_foreign_key :plan_places, :plans, on_delete: :cascade
  end
end
