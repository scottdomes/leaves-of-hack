class Admin::UsersController < ApplicationController

  before_filter :restrict_user_by_role

  def index
    @users = User.all.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def destroy
    user = User.find(params[:id])
    if User.destroy(user.id)
      UserMailer.deletion_email(user).deliver_now
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

  def impersonate
    @user = User.find(params[:id])
    session[:admin_id] = session[:user_id]
    session[:user_id] = @user.id
    redirect_to admin_users_path
  end

  protected

  def restrict_user_by_role
    unless current_user && (current_user.admin? || impersonating?)
      flash[:alert] = "Get outta there! Not authorized."
      redirect_to root_path
    end
  end

  def impersonating?
    if session[:admin_id].present?
      user = User.find(session[:admin_id])
      user.admin?
    else
      false
    end
  end

  def user_params
    params.require(:user).permit(
      :firstname, :lastname, :admin, :email
      )
  end

  helper_method :impersonating?
end
