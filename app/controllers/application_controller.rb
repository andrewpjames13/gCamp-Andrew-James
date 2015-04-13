class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def authenticate
    if not current_user
      redirect_to signin_path, notice: 'Not signed in!'
    end
  end

  def current_member
    @project = Project.find_by_id(params[:project_id])
    @user = User.find_by_id(session[:user_id])
    count = 0
    @project.memberships.each do |member|
      if @user.admin? || member.user_id == current_user.id
        count += 1
      end
    end
      if count == 0
        redirect_to projects_path, notice: 'You do not have access to that project'
      end
  end

  helper_method :current_member
  helper_method :current_user

end
