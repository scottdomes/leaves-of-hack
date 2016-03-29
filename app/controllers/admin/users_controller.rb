class Admin::UsersController < ApplicationController

  before_filter :restrict_user_by_role

  def index
    @users = User.all.page(params[:page])
  end

  protected

  def restrict_user_by_role
    unless current_user.admin
      flash[:alert] = "Get outta there! Not authorized."
      redirect_to root_path
    end
  end
end
