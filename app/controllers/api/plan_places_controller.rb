class Api::PlanPlacesController < ApplicationController
  include GeoPointConversion

  before_action :set_plan
  before_action :set_plan_place, only: [ :show, :destroy ]

  def index
    render json: @plan.plan_places
  end

  def show
    render json: @plan_place
  end

  def create
    plan_place = PlanPlace.new(place_params.merge(plan_id: @plan.id))

    if plan_place.save
      render json: plan_place, status: :created, location: api_plan_place_url(@plan.id, plan_place.id)
    else
      render json: { errors: plan_place.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    @plan_place.destroy!
  end

  private

  def place_params
    raw_params = params.expect(place: [ :latitude, :longitude ])
    convert_coordinates_to_point(raw_params, point_key: :location)
  end

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end

  def set_plan_place
    @plan_place = @plan.plan_places.find(params[:id])
  end
end
