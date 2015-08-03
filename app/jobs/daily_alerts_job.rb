class DailyAlertsJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    @lists = {}
    List.all.each do |list|
      alerted = list.alerted_items
      unless alerted == []
        @lists[list.name] = {
          summary: "#{list.name} has #{alerted.length} alerts.",
          items: alerted,
        }
      end
    end
    unless @lists == {}
      User.emails.each { |email| Emailer.daily_alerts(email, @lists).deliver_later }
    end
  end
end
