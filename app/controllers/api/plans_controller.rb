class Api::PlansController < ApplicationController
  before_action :authenticate_with_api_key!
  before_action :set_plan, only: [ :show, :update, :destroy ]

  def index
    render json: Plan.all.includes(:plan_places), include: :plan_places
  end

  def show
    render json: @plan, include: :plan_places
  end

  def create
    plan = Plan.new(plan_params)

    Plan.transaction do
      plan.save!
      plan.plan_members.create!(user_id: current_user.id, role: :admin)
    end

    render json: plan, status: :created, location: api_plan_url(plan)

  rescue ActiveRecord::RecordInvalid
    errors = plan&.errors&.full_messages || [ "Failed to create plan" ]
    render json: { errors: errors }, status: :unprocessable_content
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
