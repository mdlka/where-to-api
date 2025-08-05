class PlanPlace < ApplicationRecord
  belongs_to :plan

  validates :name, presence: true, length: { minimum: 3 }

  def owner?(user)
    user.id == user_id
  end
end
