class Plan < ApplicationRecord
  has_many :plan_places
  has_many :places, through: :plan_places

  validates :title, presence: true
end
