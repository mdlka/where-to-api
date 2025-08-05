class Plan < ApplicationRecord
  has_many :plan_places
  has_many :plan_members
  has_many :members, through: :plan_members, source: :user

  validates :title, presence: true

  def admin?(user)
    plan_members.exists?(user: user, role: :admin)
  end
end
