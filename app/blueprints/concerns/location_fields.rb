module LocationFields
  def add_location_fields(location_method:)
    field :longitude do |place, _|
      "#{place.send(location_method).x}"
    end

    field :latitude do |place, _|
      "#{place.send(location_method).y}"
    end
  end
end
