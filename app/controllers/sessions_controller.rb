class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user and @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome"
    else
      flash[:login_alert] = "Email / password combination invalid"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "Successfully Logged out!"
  end

  private

  def session_params
    params.require(:session).permit(:email)
  end

end
