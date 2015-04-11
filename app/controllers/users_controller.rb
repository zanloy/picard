class UsersController < ApplicationController

  skip_before_filter :require_login, only: [:new, :create]

  before_filter :require_admin, only: [:edit, :destroy, :update]

  def index
    @users = User.all
  end

  def show
    @user = User.find(edit_params)
    @logitems = @user.log_items
  end

  def new
    @user = User.new
  end

  def create
    User.create create_params
    redirect_to root_path
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

  def create_params
    params.require(:user).permit(:email, :new_password, :name)
  end

  def edit_params
    params.require(:id)
  end

  def update_params
    params.require(:user).permit(:new_password, :name, :enabled, :admin)
  end

end
