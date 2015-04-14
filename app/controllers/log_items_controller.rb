class LogItemsController < ApplicationController

  def index
    @logitems = LogItem.all.order(when: :desc).limit(25)
  end

  def show
    @logitem = LogItem.find(edit_params)
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
    @logitem = LogItem.find(edit_params)
    @pocs = User.where('enabled = ?', true)
  end

  def destroy
    LogItem.destroy(edit_params)
    redirect_to log_items_path, notice: 'Log Item deleted.'
  end

  def update
    logitem = LogItem.find(edit_params)
    if logitem.update_attributes(create_params)
      redirect_to log_item_path(logitem), notice: 'Update successful.'
    else
      redirect_to log_item_path(logitem), error: 'Update failed.'
    end
  end

  private

  def edit_params
    params.require(:id)
  end

  def create_params
    p = params.require(:log_item).permit(:poc_id, :when, :environment_id, :name, :description, :all_tags)
    p[:entered_by_id] = session[:user_id]
    p[:poc_id] = session[:user_id] if (p[:poc].nil? or p[:poc].empty?)
    p[:when] = Time.now if not p.has_key? :when
    p
  end

end
