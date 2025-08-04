class PlanMember < ApplicationRecord
  belongs_to :plan
  belongs_to :user

  enum :role, {
    member: "member",
    admin: "admin"
  }, validate: true

  validates :user_id, uniqueness: { scope: :plan_id, message: "is already a member of this plan" }
end
