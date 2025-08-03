class PlanMember < ApplicationRecord
  belongs_to :plan
  belongs_to :user

  enum :role, {
    member: "member",
    admin: "admin"
  }
end
