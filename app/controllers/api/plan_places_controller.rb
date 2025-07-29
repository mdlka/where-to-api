class Api::PlanPlacesController < ApplicationController
  before_action :set_plan

  def index
    render json: @plan.plan_places, status: :ok
  end

  def show
    render json: @plan.plan_places.find(params[:id]), status: :ok
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
    @plan.plan_places.find(params[:id]).destroy
    head :no_content
  end

  private

  def place_params
    raw_params = params.expect(place: [ :latitude, :longitude ])

    if raw_params[:latitude] && raw_params[:longitude]
      raw_params[:location] = Geo.point(raw_params.delete(:longitude).to_f, raw_params.delete(:latitude).to_f)
    end

    raw_params
  end

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end
end
