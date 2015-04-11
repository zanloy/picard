class SessionsController < ApplicationController

  skip_before_filter :require_login

  def login

  end

  def login_attempt
    user = User.authenticate(email_param, password_param)
    if user
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to signin_path, notice: 'Login failed.'
    end
  end

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
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
