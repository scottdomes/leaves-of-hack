class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :impersonating?

  protected

  def restrict_access
    if !current_user
      flash[:alert] = "You must log in."
      redirect_to new_session_path
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

  def current_user
    begin
      @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
      @current_user = User.find(session[:admin_id]) if session[:admin_id]
    end
  end

  helper_method :current_user
end
