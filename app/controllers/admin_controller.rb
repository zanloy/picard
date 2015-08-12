class AdminController < ApplicationController

  load_and_authorize_resource

  def index
    @enabled_users = User.enabled.sorted
    @disabled_users = User.all.disabled
    @banned_users = User.banned.sorted
  end

  def enable_user
    user = User.find(user_param)
    user.enabled = true
    respond_to do |format|
      if user.save
        Emailer.account_enabled(user).deliver_later
        format.html { redirect_to admin_path, notice: "#{user.name_or_email} has been enabled." }
        format.json { render 'users/show', status: :ok, location: @user }
      else
        format.html { redirect_to admin_path, alert: 'Failed to enable account.' }
        format.json { render @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def user_param
    params.require(:user_id)
  end

end
