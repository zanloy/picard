# frozen_string_literal: true

# Controller for Users
class UsersController < ApplicationController
  skip_before_action :require_login, only: %i[new create]

  # We run :current_user before :new and :create because if the user is created
  # by an admin, then it behaves differently.
  before_action :current_user, only: %i[new create]
  before_action :set_user, except: %i[create index new]

  load_and_authorize_resource

  def create
    if create_params[:email] =~ /.*@sparcedge.com/i
      redirect_to signin_path, alert: 'Use the Sign in with Google link to setup your sparcedge.com account.'
    else
      @user = User.create(create_params)

      respond_to do |format|
        if @user.save
          if @current_user
            format.html { redirect_to user_path(@user) }
          else
            session[:user_id] = @user.id
            format.html { redirect_to root_path }
          end
          format.json { render :show, status: :created, location: @user }
        else
          format.html { render :new, alert: @user.errors.values.flatten.join('. ') }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: 'User was deleted.'
  end

  def edit
  end

  def enable
    @user.enabled = true
    respond_to do |format|
      if @user.save
        Emailer.delay.account_enabled(@user)
        format.html { redirect_to admin_path, notice: "#{@user.name_or_email} has been enabled." }
        format.json { render 'users/show', status: :ok, location: @user }
      else
        format.html { redirect_to admin_path, alert: 'Failed to enable account.' }
        format.json { render @user.errors, status: :unprocessable_entity }
      end
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

  def index
    @users = User.enabled.sorted
  end

  def new
    @user = User.new
  end

  def show
    @changes = @user.engineering_changes.timeline.limit(10)
  end

  def update
    respond_to do |format|
      if @user.update(update_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def set_user
    id = params[:id] || params[:user_id]
    @user = User.find(id)
  end

  def create_params
    params.require(:user).require(:new_password)
    params.require(:user).permit(:name, :email, :new_password)
  end

  def update_params
    params.require(:user).permit(:name, :new_password, :avatar).tap do |whitelist|
      if params[:user].has_key? :profile_attributes
        whitelist[:profile_attributes] = params[:user][:profile_attributes].permit(:company, :phone, :im_address, :va_email, :alternative_contact, :slack_username)
      end
      if params[:user].has_key? :notification_attributes
        whitelist[:notification_attributes] = params[:user][:notification_attributes].permit(:on_new_change, :on_new_event)
      end
      if admin?
        whitelist[:enabled] = params[:user][:enabled]
        whitelist[:banned] = params[:user][:banned]
        whitelist[:admin] = params[:user][:admin]
        if params[:user].has_key? :notification_attributes
          whitelist[:notification_attributes][:on_new_user] = params[:user][:notification_attributes][:on_new_user] if @user.admin
        end
      end
    end
  end

end
