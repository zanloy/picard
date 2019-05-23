# frozen_string_literal: true

# Controller for Application
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :store_path, :require_login

  helper_method :admin?, :active?

  rescue_from CanCan::AccessDenied do
    respond_to do |format|
      format.html { redirect_to root_path, alert: 'You do not have access to do that.' }
      format.json { render nothing: true, status: :forbidden }
    end
  end

  def admin?
    return true if @current_user.try(:admin)
  end

  # def require_admin
  #   if not admin?
  #     redirect_to :back, alert: 'Admin rights are required to perform that activity.'
  #  end
  # end

  def active?(controller)
    'active' if controller_name == controller.to_s
  end

  private

  def current_user
    begin
      user = User.find(session[:user_id]) if session[:user_id]
    rescue StandardError
      return nil
    end
    user ||= authenticate_with_http_token { |t, _o| user = Profile.find_by_apikey(t).user }
    @current_user ||= user
  end

  def require_login
    user = current_user
    if user.nil?
      respond_to do |format|
        format.html { redirect_to signin_path }
        format.json { render nothing: true, status: :unauthorized }
      end
    elsif user.enabled? == false
      respond_to do |format|
        format.html { redirect_to disabled_path }
        format.json { render nothing: true, status: :unauthorized }
      end
    end
  end

  def store_path
    session[:last_path] = request.env['PATH_INFO']
  end
end
