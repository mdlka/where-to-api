class PlanMemberBlueprint < Blueprinter::Base
  identifier :id

  fields :plan_id, :user_id, :role
end
