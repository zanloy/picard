class UsersController < ApplicationController

  def index
    @users = User.all
  end

  def edit
    @user = User.find(edit_params)
  end

  def destroy
    User.destroy edit_params
    redirect_to :back, notice: 'User was successfully deleted.'
  end

  def update
    user = User.find(edit_params)
    if user.update_attributes(update_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      redirect_to :back, notice: 'There was an error updating user.'
    end
  end

  private

  def edit_params
    params.require(:id)
  end

  def update_params
    params.require(:user).permit(:admin)
  end

end
