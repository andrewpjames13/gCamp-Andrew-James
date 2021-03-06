class MembershipsController < ApplicationController
  layout "internal"
  before_action :current_member

  def index
    @memberships = Membership.all
    @project = Project.find(params[:project_id])
    @users = User.all
    @membership = @project.memberships.new
    @current_membership = Membership.where(user_id: @user.id, project_id: @project.id)

  end

  def create
    @project = Project.find(params[:project_id])
    @user = User.find_by(params[:id])
    @membership = @project.memberships.new(membership_params)
    if @membership.save
      redirect_to project_memberships_path(@project), notice: "#{@user.full_name} was successfully added"
    else
      redirect_to project_memberships_path(@project), notice: "Member was not added"
    end
  end

  def update
    @membership = Membership.find(params[:id])
    @memberships = @project.memberships
    if @membership.update(role: 2) && @memberships.where(role: 2).count == 1
      redirect_to :back, notice: "Projects much have at least on owner"
    else @memberships.where(role: 2).count > 1
    @project = Project.find(params[:project_id])
    @membership.update(membership_params)
      redirect_to project_memberships_path(@project), notice: "#{@membership.user.full_name} was successfully updated."
    end
  end

  def destroy
    @project = Project.find(params[:project_id])
    @membership = Membership.find(params[:id])
    @membership.destroy
    if params[:from]=='own_membership'
      redirect_to projects_path, notice: "#{@membership.user.full_name} was successfully removed"
    else
      redirect_to project_memberships_path(@project), notice: "Member was successfully deleated"
    end
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

end
