class ProjectsController < ApplicationController

  before_action :authenticate

  def index
    @projects = Project.all
  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to project_path(@project), notice: "Project was successfully created!"
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
    @task = Task.find(params[:id])
  end

  def destroy
    @project = Project.find(params[:id])
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  def project_params
    params.require(:project).permit(:name)
  end

end
