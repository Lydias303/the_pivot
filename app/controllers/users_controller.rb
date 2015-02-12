class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    authorize! :read, @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: "Welcome #{@user.first_name}"
    else
      redirect_to new_user_path, error: "Invalid Credentials"
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to :back
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :image, :about_me)
  end
end
