class Place < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }

  scope :in_radius, ->(long, lat, radius_meters) do
    where(
      "ST_DWithin(location, :point, :radius)",
      point: Geo.to_wkt(Geo.point(long, lat)), radius: radius_meters
    )
  end
end
