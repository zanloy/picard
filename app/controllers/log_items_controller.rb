class LogItemsController < ApplicationController

  def index
    @logitem = LogItem.new # For the quick add form
    @logitems = LogItem.all
  end

  def create
    LogItem.create create_params
    redirect_to :back
  end

  private

  def create_params
    p = params.require(:log_item).permit(:name, :all_tags)
    p[:user_id] = session[:user_id]
    p[:when] = Time.now
    p
  end

end
