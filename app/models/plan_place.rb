class PlanPlace < ApplicationRecord
  belongs_to :plan

  validates :name, presence: true, length: { minimum: 3 }
end
