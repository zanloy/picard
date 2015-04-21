class LogItemsController < ApplicationController

  before_filter :set_log_item, except: [:index, :new]

  def index
    @logitems = LogItem.timeline.page(page_param)
  end

  def show
  end

  def new
    @logitem = LogItem.new
    @pocs = User.where('enabled = ?', true)
  end

  def create
    LogItem.create create_params
    redirect_to log_items_path
  end

  def edit
    @pocs = User.enabled.sorted
  end

  def update
    if @logitem.update_attributes(create_params)
      redirect_to log_item_path(@logitem), notice: 'Update successful.'
    else
      redirect_to log_item_path(@logitem), error: 'Update failed.'
    end
  end

  def destroy
    @logitem.destroy
    redirect_to log_items_path, notice: 'Log Item deleted.'
  end

  private

  def set_log_item
    @logitem = LogItem.find(params.require(:id))
  end

  def page_param
    if params.has_key? :page
      return params[:page]
    else
      return 1
    end
  end

  def create_params
    p = params.require(:log_item).permit(:poc_id, :when, :environment_id, :name, :description, :all_tags)
    p[:entered_by_id] = session[:user_id]
    p[:poc_id] = session[:user_id] if (p[:poc_id].nil? or p[:poc_id].empty?)
    p[:when] = Time.now if not p.has_key? :when
    p
  end

end
