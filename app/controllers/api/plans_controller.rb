class Api::PlansController < ApplicationController
  before_action :authenticate_with_api_key!
  before_action :set_plan, only: [ :show, :update, :destroy ]
  before_action :validate_destroy_access!, only: [ :destroy ]

  def index
    render json: PlanBlueprint.render(current_user.plans.includes(:plan_places))
  end

  def show
    render json: PlanBlueprint.render(@plan)
  end

  def create
    plan = Plan.new(plan_params)

    Plan.transaction do
      plan.save!
      plan.plan_members.create!(user_id: current_user.id, role: :admin)
    end

    render json: PlanBlueprint.render(plan), status: :created, location: api_plan_url(plan)

  rescue ActiveRecord::RecordInvalid
    errors = plan&.errors&.full_messages || [ "Failed to create plan" ]
    render json: { errors: errors }, status: :unprocessable_content
  end

  def update
    if @plan.update(plan_params)
      render json: PlanBlueprint.render(@plan)
    else
      render json: { errors: @plan.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    @plan.destroy!
  end

  private

  def set_plan
    @plan = current_user.plans.find(params[:id])
  end

  def validate_destroy_access!
    head :forbidden unless @plan.admin?(current_user)
  end

  def plan_params
    params.expect(plan: [ :title, :is_active ])
  end
end
