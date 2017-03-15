# frozen_string_literal: true
class DailyAlertsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    expiring_certs = Certificate.expires_soon
    if expiring_certs.count > 0
      User.emails.each { |email| Emailer.delay.daily_alerts(email, expiring_certs.to_a) }
    end
  end
end
