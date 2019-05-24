# frozen_string_literal: true

# Controller for Subscriptions
class SubscriptionsController < ApplicationController
  before_action :set_subscription, only: :destroy

  load_and_authorize_resource

  def index; end

  def create
    @subscribable = find_subscribable
    @subscription = @subscribable.subscriptions.build(user_id: @current_user[:id])
    if @subscription.save
      redirect_to :back, notice: 'Subscribed.'
    else
      redirect_to :back, error: 'There was an error while trying to save your subscription.'
    end
  end

  def destroy
    respond_to do |format|
      @subscription.destroy
      format.html { redirect_to :back }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def find_subscribable
    params.each do |name, value|
      return Regex.last_match(1).classify.constantize.find(value) if name =~ /(.+)_id$/
    end
    nil
  end

  def set_subscription
    @subscription = Subscription.find(params[:id])
  end
end
