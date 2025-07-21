class Place < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3 }

  scope :in_radius, ->(long, lat, radius_meters) {
    where(
      "ST_DWithin(location, ST_SetSRID(ST_MakePoint(?, ?), ?)::geography, ?)",
      long, lat, Utils::Geo::SRID, radius_meters
    )
  }
end
