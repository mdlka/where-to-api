module GeoPointConversion
  extend ActiveSupport::Concern

  private

  def convert_coordinates_to_point(params, point_key:, long_key: :longitude, lat_key: :latitude)
    return params unless params[long_key].present? && params[lat_key].present?

    params.except(long_key, lat_key)
          .merge(point_key => Geo.point(params[long_key].to_f, params[lat_key].to_f))
  end
end
