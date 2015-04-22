class UsersController < ApplicationController

  skip_before_filter :require_login, only: [:new, :create]

  before_filter :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :require_admin_or_self, only: [:edit, :destroy, :update]

  helper_method :is_admin_or_self?

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

  def is_admin_or_self?
    return true if is_admin?
    return true if @current_user == @user
    return false
  end

  private

  def require_admin_or_self
    if not is_admin_or_self?
      redirect_to :back, error: "You can't edit this user."
    end
  end

  def set_user
    @user = User.find(params[:id])
  end

  def create_params
    params.require(:user).permit(:email, :new_password, :name)
  end

  def update_params
    params.require(:user).permit(:new_password, :name).tap do |whitelist|
      if is_admin?
        whitelist[:enabled] = params[:user][:enabled]
        whitelist[:admin] = params[:user][:admin]
      end
      whitelist[:profile_attributes] = params[:user][:profile_attributes].permit(:company, :phone, :im_address, :va_email, :alternative_contact)
      whitelist[:notification_attributes] = params[:user][:notification_attributes].permit(:on_new_change, :on_new_event)
    end
  end

end
