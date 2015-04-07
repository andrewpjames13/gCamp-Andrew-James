class CommentsController < ApplicationController

  def create
    @task = Task.find(params[:task_id])
    @project = @task.project_id
    @user = User.find(session[:user_id])
    @comment = @task.comments.new(params_comment)
    @comment.task_id = @task.id
    @comment.user_id = @user.id
    if @comment.save
      redirect_to :back
    else
      redirect_to :back
    end
  end

  private

  def params_comment
    params.require(:comment).permit(:description, :user_id, :task_id)
  end

end
