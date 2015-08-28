class EngineeringChangesController < ApplicationController

  before_filter :set_change, except: [:index, :new, :create, :quickadd]

  load_and_authorize_resource

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
    @environments = Environment.all
  end

  def create
    @change = EngineeringChange.new create_params

    respond_to do |format|
      if from_quick_add? and add_details?
        @change.parse_title
        @environments = Environment.all
        format.html { render :new, location: @change }
      else
        @change.environment = Environment.first unless @change.environment
        if @change.save
          # Notify Slack
          begin
            if ENV.has_key? 'SLACK_WEBHOOKS'
              ENV['SLACK_WEBHOOKS'].split(',').each do |webhook|
                notifier = Slack::Notifier.new webhook
                notifier.ping "New Change: #{view_context.link_to(@change.title, engineering_change_url(@change))}"
              end
            end
          rescue
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
    @environments = Environment.all
  end

  def update
    respond_to do |format|
      if @change.update_attributes(create_params)
        format.html { redirect_to engineering_change_path(@change), notice: 'Update successful.' }
        format.json { render :show, status: :ok, location: @change }
      else
        format.html { render :edit, alert: @change.errors.full_messages.join('. ') }
        format.json { render json: @change.errors.full_messages, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @change.destroy
    respond_to do |format|
      format.html { redirect_to engineering_changes_path, notice: 'Change deleted.' }
      format.json { head :no_content }
    end
  end

  def quickadd
    render layout: 'minimal'
  end

  private

  def set_change
    @change = EngineeringChange.find(params[:id])
  end

  def page_param
    (params.has_key? :page) ? params[:page] : 1
  end

  def create_params
    parms = params.require(:engineering_change).permit(:poc_id, :when, :environment_id, :title, :description, attachments_attributes: [:id, :file, :_destroy])
    parms[:entered_by] = @current_user
    parms[:poc] = @current_user if (parms[:poc_id].nil? or parms[:poc_id].empty?)
    return parms
  end

  def from_quick_add?
    params[:engineering_change].has_key? 'quick_add'
  end

  def add_details?
    from_quick_add? and params[:commit] != 'Quick Add'
  end
end
