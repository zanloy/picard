# frozen_string_literal: true

# Controller for Alerts
class AlertsController < ApplicationController
  before_action :set_alert, only: :destroy
  before_action :set_list, only: %i[new create]

  def new
    @alert = Alert.new(list: @list)
  end

  def create
    parameters = alert_params
    parameters[:list] = @list
    alert = Alert.new(parameters)
    if alert.save
      redirect_to @list
    else
      redirect_to @list, alert: 'There was an error while trying to save your alert.'
    end
  end

  def destroy
    @alert.destroy
    respond_to do |format|
      format.html { redirect_to @alert.list, notice: 'Alert was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private

  def set_alert
    @alert = Alert.find(params[:id])
  end

  def set_list
    @list = List.find(params[:list_id])
  end

  def alert_params
    params.require(:alert).permit(:field, :operator, :value)
  end
end
