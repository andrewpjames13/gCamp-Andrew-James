class ProjectsController < ApplicationController
  layout "internal"
  # before_action :store_return_to
  before_action :authenticate


  def index
    @projects = Project.all
    @user = User.find_by_id(session[:user_id])
  end

  def something(project)
    project.memberships.each do |membership|
      if membership.user_id == @user.id
        project.name
      end
    end
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    user_id = session[:user_id]
    if @project.save
      @project.memberships.create(role: 2, user_id: user_id)
      redirect_to project_tasks_path(@project), notice: "Project was successfully created!"
    else
      render :new
    end
  end

  def edit
    @project = Project.find(params[:id])
    @submit_name = "Update Project"
  end

  def show
    @project = Project.find(params[:id])
    @user = User.find_by_id(session[:user_id])
    @membership = Membership.where(user_id: @user.id, project_id: @project.id)
    @member_id = @project.memberships.map do |member|
      member.user_id
    end
    unless @member_id.include?(@user.id) || @user.admin?
     redirect_to projects_path, notice:'You do not have access to that project'
   end
  end

  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      redirect_to projects_path, notice: 'Project was successfully destroyed.'
    else
      render :back, notice: 'You do not have access'
    end
  end

  def update
    @project = Project.find(params[:id])

      if @project.update(project_params)
        redirect_to project_path(@project), notice: 'Project was successfully updated.'
      else
          render :edit
      end

  end

  private
  def project_params
    params.require(:project).permit(:name)
  end

end
