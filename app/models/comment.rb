class Comment < ActiveRecord::Base

  after_create :send_notifications

  # Associations
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  # Validation
  validates_presence_of :commentable_id, :commentable_type, :user_id, :comment

  private

  def send_notifications
    self.commentable.subscriptions.each do |subscription|
      if subscription.user != self.user
        NewCommentEmailJob.set(wait: 20.seconds).perform_later(subscription.user, self)
      end
    end
  end

end
