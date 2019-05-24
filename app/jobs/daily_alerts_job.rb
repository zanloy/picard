# frozen_string_literal: true

# ActiveJob for daily alert emails
class DailyAlertsJob < ActiveJob::Base
  queue_as :default

  def perform(*)
    expiring_certs = Certificate.expires_soon
    User.emails.each { |email| Emailer.delay.daily_alerts(email, expiring_certs.to_a) } if expiring_certs.count.positive?
  end
end
