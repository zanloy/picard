class EngineeringChangesController < ApplicationController

  before_filter :set_change, except: [:index, :new, :create]

  def index
    @changes = EngineeringChange.timeline.page(page_param)
  end

  def show
  end

  def new
    @change = EngineeringChange.new
    @change[:poc_id] = session[:user_id]
    @change[:when] = Time.now
    @pocs = User.enabled.sorted
  end

  def create
    @change = EngineeringChange.new create_params
    if @change.save
      begin
        @change.subscriptions.build({user_id: @current_user[:id]}).save
        if @change[:poc_id] != @current_user[:id]
          @change.subscriptions.build({user_id: @change[:poc_id]}).save
        end
      rescue
      end
      Notification.where(on_new_change: true).each do |notification|
        NewChangeEmailJob.set(wait: 20.seconds).perform_later(notification.user, @change)
      end
      redirect_to engineering_changes_path
    else
      redirect_to engineering_changes_path, error: 'Saving change failed.'
    end
  end

  def edit
    @pocs = User.enabled.sorted
  end

  def update
    if submitted?
      if @change.update_attributes(create_params)
        redirect_to engineering_change_path(@change), notice: 'Update successful.'
      else
        redirect_to engineering_change_path(@change), error: 'Update failed.'
      end
    else
      redirect_to engineering_change_path(@change)
    end
  end

  def destroy
    @change.destroy
    redirect_to engineering_changes_path, notice: 'Engineering change deleted.'
  end

  private

  def set_change
    @change = EngineeringChange.find(params.require(:id))
  end

  def page_param
    if params.has_key? :page
      return params[:page]
    else
      return 1
    end
  end

  def create_params
    p = params.require(:engineering_change).permit(:poc_id, :when, :environment_id, :title, :description, :all_tags)
    p[:entered_by_id] = session[:user_id]
    p[:poc_id] = session[:user_id] if (p[:poc_id].nil? or p[:poc_id].empty?)
    p[:when] = Time.now if not p.has_key? :when
    p
  end

  def submitted?
    if params.has_key? :commit
      return true
    else
      return false
    end
  end

end
