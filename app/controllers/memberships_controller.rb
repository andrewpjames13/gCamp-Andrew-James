class MembershipsController < ApplicationController

  def index
    @memberships = Membership.all
    @project = Project.find(params[:project_id])
    @users = User.all
    @membership = @project.memberships.new
  end

  private

  def membership_params
    params.require(:membership).permit(:user_id, :project_id, :role)
  end

end
