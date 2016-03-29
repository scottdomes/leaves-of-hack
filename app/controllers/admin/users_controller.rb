class Admin::UsersController < ApplicationController

  before_filter :restrict_user_by_role

  def index
    @users = User.all.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    if User.destroy(params[:id])
      flash[:notice] = "User deleted."
      redirect_to admin_users_path
    else
      render :index
    end
  end

  def update
    @user = User.find(params[:id])

    if @user.update_attributes(user_params)
      redirect_to admin_users_path(@user)
    else
      render :edit
    end
  end

  protected

  def restrict_user_by_role
    unless current_user.admin
      flash[:alert] = "Get outta there! Not authorized."
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(
      :firstname, :lastname, :admin, :email
      )
  end
end
