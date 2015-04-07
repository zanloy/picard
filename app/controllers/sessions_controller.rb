class SessionsController < ApplicationController

  def create
    user = User.from_omniauth(env['omniauth.auth'])
    # render :text => user.inspect
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def user_params
    params.require('omniauth.auth').permit(:uid, :provider, :info, :extra)
  end

end
