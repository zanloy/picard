class UsersController < ApplicationController

  skip_before_filter :require_login, only: [:new, :create]

  before_filter :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :require_admin, only: [:edit, :destroy, :update]

  def index
    @users = User.sorted
  end

  def show
    @changes = @user.engineering_changes.timeline.limit(25)
  end

  def new
    @user = User.new
  end

  def create
    User.create create_params
    redirect_to root_path
  end

  def edit
  end

  def update
    if @user.update_attributes(update_params)
      redirect_to users_path, notice: 'User was successfully updated.'
    else
      redirect_to :back, notice: 'There was an error updating user.'
    end
  end

  def destroy
    @user.destroy
    redirect_to :back, notice: 'User was successfully deleted.'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def create_params
    params.require(:user).permit(:email, :new_password, :name)
  end

  def update_params
    params.require(:user).permit(:new_password, :name, :enabled, :admin)
  end

end
