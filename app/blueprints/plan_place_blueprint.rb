class PlanPlaceBlueprint < Blueprinter::Base
  identifier :id

  fields :plan_id, :user_id, :name

  field :longitude do |place, options|
    "#{place.location.x}"
  end

  field :latitude do |place, options|
    "#{place.location.y}"
  end
end
