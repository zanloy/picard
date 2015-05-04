class EngineeringChangesController < ApplicationController

  before_filter :set_change, except: [:index, :new, :create]
  before_filter :require_permission_to_edit, only: [:edit, :update, :destroy]

  def index
    @changes = EngineeringChange.timeline.page(page_param)
  end

  def show
  end

  def new
    @change = EngineeringChange.new
    @change[:poc_id] = session[:user_id]
    @change[:when] = Time.zone.now
    @pocs = User.enabled.sorted
  end

  def create
    @change = EngineeringChange.new create_params

    respond_to do |format|
      if from_quick_add? and add_details?
        @change.parse_title
        format.html { render :new, location: @change }
      else
        if @change.save
          begin
            @change.subscriptions.build({user_id: @current_user[:id]}).save
            if @change[:poc_id] != @current_user[:id]
              @change.subscriptions.build({user_id: @change[:poc_id]}).save
            end
          rescue
          end
          begin
            if ENV['SLACK_WEBHOOK']
              notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK'], channel: ENV['SLACK_CHANNEL'], username: 'Jean Luc Picard'
              if ENV['SLACK_ICON_URL']
                notifier.ping "New Change: #{view_context.link_to(@change.title, engineering_change_url(@change))}", icon_url: view_context.asset_url('img/picard_avatar.png')
              else
                notifier.ping "New Change: #{view_context.link_to(@change.title, engineering_change_url(@change))}", icon_emoji: ':shipit:'
              end
            end
          rescue => e
            logger.debug e
          end
          format.html do
            if from_quick_add?
              redirect_to engineering_changes_path
            else
              redirect_to engineering_change_path(@change)
            end
          end
          format.json { render :show, status: :created, location: @change }
        else
          format.html { render :new, error: 'Saving change failed.' }
          format.json { render json: @change.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  def edit
    @pocs = User.enabled.sorted
  end

  def update
    respond_to do |format|
      if @change.update_attributes(create_params)
        format.html { redirect_to engineering_change_path(@change), notice: 'Update successful.' }
        format.json { render :show, status: :ok, location: @change }
      else
        format.html { render :edit, error: 'Update failed.' }
        format.json { render json: @change.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @change.destroy
    respond_to do |format|
      format.html { redirect_to engineering_changes_path, notice: 'Engineering change deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_change
    @change = EngineeringChange.find(params.require(:id))
  end

  def require_permission_to_edit
    if is_admin? or @change.poc_id == @current_user.id or @change.entered_by_id == @current_user.id
      return
    else
      redirect_to :back, alert: 'You do not have permissions to do that.'
    end
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

  def from_quick_add?
    if params[:engineering_change].has_key? 'quick_add'
      return true
    else
      return false
    end
  end

  def add_details?
    if from_quick_add? and params[:commit] != 'Quick Add'
      return true
    else
      return false
    end
  end
end
