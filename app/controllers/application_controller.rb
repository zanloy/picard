class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :store_path, :require_login

  helper_method :is_admin?, :require_admin, :is_active?, :display_checkbox

  def is_admin?
    if @current_user && @current_user.admin
      return true
    end
    return false
  end

  def require_admin
    if not is_admin?
      redirect_to :back, alert: 'Admin rights are required to perform that activity.'
    end
  end

  def is_active?(controller)
    'active' if controller_name == controller
  end

  def display_checkbox(value)
    case value
    when true
      '<i class="glyphicon glyphicon-check"></i>'
    when false
      '<i class="glyphicon glyphicon-unchecked"></i>'
    else
      ''
    end
  end

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    user = current_user
    if user == nil
      redirect_to signin_path
    elsif user.enabled == false
      redirect_to disabled_path
    end
  end

  def store_path
    session[:last_path] = request.env['PATH_INFO']
  end

end
