class Api::Plans::PlacesController < ApplicationController
  include GeoPointConversion

  before_action :authenticate_with_api_key!
  before_action :set_plan
  before_action :set_plan_place, only: [ :show, :destroy ]
  before_action :validate_destroy_access!, only: [ :destroy ]

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

  def set_plan
    @plan = current_user.plans.find(params[:plan_id])
  end

  def set_plan_place
    @plan_place = @plan.plan_places.find(params[:id])
  end

  def validate_destroy_access!
    head :forbidden unless @plan.admin?(current_user) || @plan_place.owner?(current_user)
  end

  def place_params
    raw_params = params.expect(place: [ :latitude, :longitude ])
    convert_coordinates_to_point(raw_params, point_key: :location)
  end
end
