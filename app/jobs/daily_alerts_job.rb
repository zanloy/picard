class DailyAlertsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    Emailer.daily_alerts.deliver_later
  end
end
