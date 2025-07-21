class Api::PlacesController < ApplicationController
  before_action :set_place, only: [ :show, :update, :destroy ]

  def index
    if search_params_present?
      render json: Place.in_radius(params[:long].to_f, params[:lat].to_f, params[:radius].to_f)
    else
      render json: Place.all
    end
  end

  def show
    render json: @place
  end

  def create
    place = Place.new(place_params)

    if place.save
      render json: place, status: :created, location: api_place_url(place)
    else
      render json: { errors: place.errors.full_messages }, status: :bad_request
    end
  end

  def update
    if @place.update(place_params)
      render json: @place
    else
      render json: { errors: @place.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @place.destroy
    head :no_content
  end

  private

  def search_params_present?
    params[:long].present? && params[:lat].present? && params[:radius].present?
  end

  def place_params
    raw_params = params.expect(place: [:name, :description, :latitude, :longitude])

    if raw_params[:latitude] && raw_params[:longitude]
      raw_params[:location] = Geo.point(raw_params.delete(:longitude).to_f, raw_params.delete(:latitude).to_f)
    end

    raw_params
  end

  def set_place
    @place = Place.find(params[:id])
  end
end
