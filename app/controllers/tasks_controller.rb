class TasksController < ApplicationController
  before_action :authenticate
  before_action :set_task, only: [:show, :edit, :update, :destroy]


  def index
    @tasks = Task.all
    @project = Project.find(params[:project_id])
  end


  def show
    @project = Project.find(params[:project_id])
    @comment = Comment.new
    @user = User.find_by_id(session[:user_id])
  end

  def new
    @task = Task.new
    @project = Project.find(params[:project_id])
  end

  def edit
    @project = Project.find(params[:project_id])
  end


  def create
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new(task_params)
      if @task.save
        redirect_to project_task_path(@project, @task), notice: 'Task was successfully created.'
      else
        render :new
      end
  end


  def update
    @project = Project.find(params[:project_id])

      if @task.update(task_params)
        redirect_to project_task_path(@project, @task), notice: 'Task was successfully updated.'
      else
        render :edit
      end
  end


  def destroy
    @project = Project.find(params[:project_id])

    @task.destroy
      redirect_to project_tasks_path(@project), notice: 'Task was successfully destroyed.'
  end

  private
    def set_task
      @task = Task.find(params[:id])
    end

    def task_params
      params.require(:task).permit(:description, :due_date, :complete, :project_id )
    end
end
