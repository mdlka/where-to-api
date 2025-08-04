class AddUniqueIndexToPlanMembers < ActiveRecord::Migration[8.0]
  def change
    add_index :plan_members, [ :plan_id, :user_id ], unique: true
  end
end
