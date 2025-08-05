class Api::Plans::MembersController < ApplicationController
  before_action :authenticate_with_api_key!
  before_action :set_plan
  before_action :set_plan_member, only: [ :show, :update, :destroy ]
  before_action :validate_edit_access!, only: [ :create, :update, :destroy ]

  def index
    render json: @plan.plan_members
  end

  def show
    render json: @plan_member
  end

  def create
    plan_member = PlanMember.new(member_params.merge(plan_id: @plan.id))

    if plan_member.save
      render json: plan_member, status: :created, location: api_plan_member_url(@plan.id, plan_member.id)
    else
      render json: { errors: plan_member.errors.full_messages }, status: :unprocessable_content
    end
  end

  def update
    if @plan_member.update(params.expect(member: [ :role ]))
      render json: @plan_member
    else
      render json: { errors: @plan_member.errors.full_messages }, status: :unprocessable_content
    end
  end

  def destroy
    @plan_member.destroy!
  end

  private

  def set_plan
    @plan = current_user.plans.find(params[:plan_id])
  end

  def set_plan_member
    @plan_member = @plan.plan_members.find(params[:id])
  end

  def validate_edit_access!
    head :forbidden unless @plan.admin?(current_user)
  end

  def member_params
    params.expect(member: [ :user_id, :role ])
  end
end
