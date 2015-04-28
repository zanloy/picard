class UsersController < ApplicationController

  skip_before_filter :require_login, only: [:new, :create]

  before_filter :set_user, only: [:show, :edit, :update, :destroy, :generate_apikey]
  before_filter :require_admin_or_self, only: [:edit, :destroy, :update, :generate_apikey]

  helper_method :is_admin_or_self?

  def index
    @users = User.sorted
  end

  def show
    @changes = @user.engineering_changes.timeline.limit(10)
  end

  def new
    @user = User.new
    render layout: 'login' if not @current_user
  end

  def create
    parms = create_params
    errors = []
    if User.find_by_email(parms[:email])
      errors << 'That email address is already registered.'
    end
    if parms[:new_password].length < 8
      errors << 'Password must be at least 8 characters.'
    end
    if errors.empty?
      User.create create_params
      redirect_to root_path
    else
      @user = User.new(parms)
      redirect_to :back, alert: errors.join
    end
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

  def generate_apikey
    @user.profile.apikey = SecureRandom.hex(32)
    if @user.profile.save!
      redirect_to user_path(@user), notice: 'New APIKey was generated. The old key will no longer work.'
    else
      redirect_to :back, notice: 'There was an error updating your apikey.'
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
    id = params[:id] || params[:user_id]
    @user = User.find(id)
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
