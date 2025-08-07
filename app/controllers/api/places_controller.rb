class Api::PlacesController < ApplicationController
  include GeoPointConversion

  before_action :set_place, only: [ :show, :update, :destroy ]

  def index
    if search_params_present?
      places_in_radius = Place.in_radius(params[:long].to_f, params[:lat].to_f, params[:radius].to_f)
      render json: PlaceBlueprint.render(places_in_radius)
    else
      render json: PlaceBlueprint.render(Place.all)
    end
  end

  def show
    render json: PlaceBlueprint.render(@place)
  end

  def create
    place = Place.new(place_params)

    if place.save
      render json: PlaceBlueprint.render(place), status: :created, location: api_place_url(place)
    else
      render json: { errors: place.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    if @place.update(place_params)
      render json: PlaceBlueprint.render(@place)
    else
      render json: { errors: @place.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    @place.destroy!
  end

  private

  def search_params_present?
    params[:long].present? && params[:lat].present? && params[:radius].present?
  end

  def place_params
    raw_params = params.expect(place: [ :name, :description, :latitude, :longitude ])
    convert_coordinates_to_point(raw_params, point_key: :location)
  end

  def set_place
    @place = Place.find(params[:id])
  end
end
