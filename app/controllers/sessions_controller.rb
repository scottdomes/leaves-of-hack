class SessionsController < ApplicationController
  def new
  end

  def admin_switch
    user = User.find(params[:user_id]) if User.exists?(params[:user_id])
    if user && !user.admin
      session[:admin_id] = session[:user_id]
      session[:user_id] = params[:user_id]
      redirect_to :back
    else
      flash[:notice] = "No user found. Dummy"
      redirect_to :back
    end
  end

  def admin_revert
    session[:user_id] = session[:admin_id]
    session[:admin_id] = nil
    redirect_to :back
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      session[:admin_id] = user.id if user.admin
      redirect_to poems_path, notice: "Welcome back, #{user.firstname}!"
    else
      flash.new[:alert] = "Login failed..."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    session[:admin_id] = nil
    redirect_to poems_path, notice: "Adios!"
  end
end
