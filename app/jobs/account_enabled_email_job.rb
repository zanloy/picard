class AccountEnabledEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user)
    Emailer.account_enabled(user).deliver_later
  end
end
