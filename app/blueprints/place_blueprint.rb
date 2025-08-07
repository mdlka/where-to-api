class PlaceBlueprint < Blueprinter::Base
  identifier :id

  fields :name, :description

  field :longitude do |place, options|
    "#{place.location.x}"
  end

  field :latitude do |place, options|
    "#{place.location.y}"
  end
end
