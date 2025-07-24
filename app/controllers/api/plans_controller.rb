class Api::PlansController < ApplicationController
  before_action :set_plan, only: [ :show, :update, :destroy ]

  def index
    render json: Plan.all, include: :places, status: :ok
  end

  def show
    render json: @plan, include: :places, status: :ok
  end

  def create
    plan = Plan.new(plan_params)

    if plan.save
      render json: plan, status: :created, location: api_plan_url(plan)
    else
      render json: { errors: plan.errors.full_messages }, status: :bad_request
    end
  end

  def update
    if @plan.update(plan_params)
      render json: @plan, status: :ok
    else
      render json: { errors: @plan.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    @plan.destroy
    head :no_content
  end

  private

  def plan_params
    params.expect(plan: [ :title, :is_active ])
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end
end
