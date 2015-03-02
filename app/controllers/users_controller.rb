class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
    @submit_name = "Create User"
  end

  def edit
    @user = User.find(params[:id])
    @submit_name = "Update User"
  end

  def show
    @user = User.find(params[:id])
  end

  def update
      if @user.update(user_params)
        redirect_to users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
  end

  def create
    @user = User.new(user_params)
      if @user.save
        redirect_to users_path, notice: 'User was successfully created.'
      else
        render :new
      end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      redirect_to users_path, notice: "User was successfully deleted."
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
