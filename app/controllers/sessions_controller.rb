class SessionsController < ApplicationController

  skip_before_filter :store_path, :require_login

  def login
    render layout: 'login'
  end

  def disabled
    user = current_user
    if user and user.enabled
      redirect_to root_path
    else
      render layout: 'login'
    end
  end

  def login_attempt
    user = User.authenticate(email_param, password_param)
    if user
      session[:user_id] = user.id
      if not session[:last_path].nil?
        redirect_to session[:last_path]
      else
        redirect_to root_path
      end
    else
      redirect_to signin_path, error: 'Login failed.'
    end
  end

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

  private

  def email_param
    params.require(:email)
  end

  def password_param
    params.require(:password)
  end

end
