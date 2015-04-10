class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :require_login

  helper_method :current_user, :is_admin?, :require_admin

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_admin?
    user = current_user
    if user && user.admin
      return true
    end
    return false
  end

  def require_admin
    if not is_admin?
      redirect_to :back, notice: 'Admin rights are required to perform that activity.'
    end
  end

  private

  def require_login
    unless current_user
      redirect_to signin_path
    end
  end

end
