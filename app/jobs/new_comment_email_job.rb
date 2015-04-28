class NewCommentEmailJob < ActiveJob::Base
  queue_as :default

  def perform(user, comment)
    Emailer.new_comment(user, comment).deliver_later
  end
  
end
