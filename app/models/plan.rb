class Plan < ApplicationRecord
  has_many :plan_places

  validates :title, presence: true
end
