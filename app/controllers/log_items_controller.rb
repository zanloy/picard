class LogItemsController < ApplicationController

  def index
    @logitems = LogItem.all.order(when: :desc).limit(25)
  end

  def new
    @logitem = LogItem.new
    @pocs = User.where('enabled = ?', true)
  end

  def create
    LogItem.create create_params
    redirect_to log_items_path
  end

  private

  def create_params
    p = params.require(:log_item).permit(:poc_id, :environment_id, :name, :all_tags)
    p[:entered_by_id] = session[:user_id]
    p[:when] = Time.now
    p
  end

end
