class Api::PlacesController < ApplicationController
  before_action set_place, only: [ :show, :update, :destroy ]

  def index
    render json: Place.all
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

  def place_params
    params.expect(place: [:name, :description, :latitude, :longitude])
  end

  def set_place
    @place = Place.find(params[:id])
  end
end
