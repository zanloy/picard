class SubscriptionsController < ApplicationController

  before_action :set_subscription, only: :destroy

  def index
  end

  def create
    @subscribable = find_subscribable
    @subscription = @subscribable.subscriptions.build({user_id: @current_user[:id]})
    if @subscription.save
      redirect_to :back, notice: 'You are now subscribed.'
    else
      redirect_to :back, error: 'There was an error while trying to save your subscription.'
    end
  end

  def destroy
    respond_to do |format|
      if is_admin? or @subscription.user == @current_user
        @subscription.destroy
        format.html { redirect_to :back, notice: 'Subscription deleted.' }
        format.json { head :no_content }
      else
        format.html { redirect_to :back, error: 'You do not have access to do that.' }
        format.json { head :no_content, status: :unauthorized }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def find_subscribable
    params.each do |name, value|
      if name =~ /(.+)_id$/
        return $1.classify.constantize.find(value)
      end
    end
    nil
  end

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end

end
