class NewUserEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user, new_user)
    Emailer.new_user(user, new_user).deliver_later
  end
  
end
