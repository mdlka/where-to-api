class Api::PlanPlacesController < ApplicationController
  before_action :set_plan

  def index
    render json: @plan.plan_places, status: :ok
  end

  def show
    render json: @plan.plan_places.find_by!(place_id: params[:id]), status: :ok
  end

  def create
    plan_place = PlanPlace.new(plan_place_params.merge(plan_id: @plan.id))

    if plan_place.save
      render json: plan_place, status: :created, location: api_plan_place_url(@plan.id, plan_place.place_id)
    else
      render json: { errors: plan_place.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @plan.plan_places.find_by!(place_id: params[:id]).destroy
    head :no_content
  end

  private

  def plan_place_params
    params.expect(plan_place: [ :place_id ])
  end

  def set_plan
    @plan = Plan.find(params[:plan_id])
  end
end
