class Api::PlanMembersController < ApplicationController
  before_action :set_plan
  before_action :set_plan_member, only: [ :show, :update, :destroy ]

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
    @plan = Plan.find(params[:plan_id])
  end

  def set_plan_member
    @plan_member = @plan.plan_members.find(params[:id])
  end

  def member_params
    params.expect(member: [ :user_id, :role ])
  end
end
