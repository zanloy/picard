class NewChangeEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user, change)
    Emailer.new_change(user, change).deliver_later
  end
end
