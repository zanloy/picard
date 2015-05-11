class Comment < ActiveRecord::Base

  after_create :send_notifications
  after_save :tagify

  # Associations
  belongs_to :commentable, polymorphic: true
  belongs_to :user
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings

  # Validation
  validates_presence_of :commentable_id, :commentable_type, :user_id, :comment

  private

  def tagify
    words = self.comment.split
    hashtags = words.select { |word| word[0] == '#' }
    tags = hashtags.uniq.map do |hashtag|
      hashtag[0] = ''
      Tag.where(name: hashtag.downcase.strip).first_or_create!
    end
    logger.debug "tags = #{tags.inspect}"
    self.tags = tags
  end

  def send_notifications
    self.commentable.subscriptions.each do |subscription|
      unless subscription.user == self.user
        NewCommentEmailJob.set(wait: 20.seconds).perform_later(subscription.user, self)
      end
    end
  end

end
