class PlanPlace < ApplicationRecord
  belongs_to :plan
  belongs_to :place
end
