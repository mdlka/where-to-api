class Api::PlansController < ApplicationController
  before_action :set_plan, only: [ :show, :update, :destroy ]

  def index
    render json: Plan.all.includes(:plan_places), include: :plan_places
  end

  def show
    render json: @plan, include: :plan_places
  end

  def create
    plan = Plan.new(plan_params)

    if plan.save
      render json: plan, status: :created, location: api_plan_url(plan)
    else
      render json: { errors: plan.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    if @plan.update(plan_params)
      render json: @plan
    else
      render json: { errors: @plan.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    @plan.destroy!
  end

  private

  def plan_params
    params.expect(plan: [ :title, :is_active ])
  end

  def set_plan
    @plan = Plan.find(params[:id])
  end
end
