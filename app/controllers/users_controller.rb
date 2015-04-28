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
      redirect_to :back, alert: 'That email address is already registered.'
    else
      user = User.create(create_params)
      if user.errors.empty?
        Notification.where(on_new_user: true).each do |notification|
          NewUserEmailJob.set(wait: 20.seconds).perform_later(notification.user, user)
        end
        redirect_to root_path
      else
        redirect_to :back, alert: user.errors.values.flatten.join('. ')
      end
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
      whitelist[:profile_attributes] = params[:user][:profile_attributes].permit(:company, :phone, :im_address, :va_email, :alternative_contact)
      whitelist[:notification_attributes] = params[:user][:notification_attributes].permit(:on_new_change, :on_new_event)
      if is_admin?
        whitelist[:enabled] = params[:user][:enabled]
        whitelist[:admin] = params[:user][:admin]
        whitelist[:notification_attributes][:on_new_user] = params[:user][:notification_attributes][:on_new_user] if @user.admin
      end
    end
  end

end
