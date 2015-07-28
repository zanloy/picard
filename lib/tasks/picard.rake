namespace :picard do
  desc "Checks for all alerts in Picard lists"
  task check_alerts: :environment do
    Emailer.daily_alerts.deliver_now
  end
end
