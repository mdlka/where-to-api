class PlanPlaceBlueprint < Blueprinter::Base
  extend LocationFields

  identifier :id

  fields :plan_id, :user_id, :name

  add_location_fields(location_method: :location)
end
