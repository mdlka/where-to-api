class CreatePlanMembers < ActiveRecord::Migration[8.0]
  def change
    create_enum :plan_member_role, %w[ member admin ]

    create_table :plan_members do |t|
      t.references :plan, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.enum :role, enum_type: :plan_member_role, default: "member", null: false

      t.timestamps
    end
  end
end
