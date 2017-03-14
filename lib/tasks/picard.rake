# frozen_string_literal: true
namespace :picard do
  desc "Checks for all alerts in Picard lists"
  task check_alerts: :environment do
    DailyAlertsJob.perform_now
  end
end
