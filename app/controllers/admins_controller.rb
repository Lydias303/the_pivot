class AdminsController < ApplicationController
  def show
    @admin = Admin.find(params[:id])
    authorize! :read, @admin
  end

  def new
    @admin = Admin.new
    authorize! :read, @admin
  end

  def create
    @admin = Admin.new(admin_params)
    if @admin.save
      session[:admin_id] = @admin.id
      redirect_to root_path, notice: "Admin created successfully."
    else
      redirect_to new_admin_path, error: "Invalid  Credentials"
    end
  end

  private

  def admin_params
    params.require(:admin).permit(:first_name, :last_name, :email, :password)
  end
end
