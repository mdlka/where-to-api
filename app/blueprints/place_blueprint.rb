class PlaceBlueprint < Blueprinter::Base
  extend LocationFields

  identifier :id

  fields :name, :description

  add_location_fields(location_method: :location)
end
