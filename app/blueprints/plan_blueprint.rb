class PlanBlueprint < Blueprinter::Base
  identifier :id

  fields :title, :is_active
  association :plan_places, blueprint: PlanPlaceBlueprint
end
