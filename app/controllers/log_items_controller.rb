class LogItemsController < ApplicationController

  def index
    # For the quick add form
    @logitem = LogItem.new
    @pocs = User.where('enabled = ?', true)

    @logitems = LogItem.all.order(when: :desc)
  end

  def create
    LogItem.create create_params
    redirect_to :back
  end

  private

  def create_params
    p = params.require(:log_item).permit(:poc_id, :environment_id, :name, :all_tags)
    p[:entered_by_id] = session[:user_id]
    p[:when] = Time.now
    p
  end

end
