class EngineeringChange < ActiveRecord::Base

  before_create :add_when
  after_create :send_notifications, :setup_subscriptions

  before_save :parse_title
  after_save :tagify

  # Associations
  belongs_to :entered_by, class_name: User
  belongs_to :poc, class_name: User
  belongs_to :environment
  has_many :attachments
  accepts_nested_attributes_for :attachments, allow_destroy: true, reject_if: :all_blank
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :subscriptions, as: :subscribable, dependent: :destroy

  # Scopes
  default_scope { order(when: :desc) }
  scope :timeline, -> { order(when: :desc) }

  # Validation
  validates :title, presence: true, length: { maximum: 142 }

  self.per_page = 15

  def has_description?
    ! (description.nil? or description.empty?)
  end

  def has_comments?
    comments.count > 0
  end

  def subscription_for(id)
    subscriptions.find_by_user_id(id)
  end

  def subscribed?(id)
    if subscription_for(id)
      return true
    else
      return false
    end
  end

  def tags_csv
    self.tags.map(&:name).join(', ')
  end

  def parse_title
    return if self.title.nil?
    words = self.title.split
    # Test for environment
    words.each_with_index do |word, index|
      if word == 'in'
        # Get the next word
        environment_str = words[index + 1]
        # Remove punctuation etc
        environment_str.gsub!(/[^a-zA-Z0-9\-_]/, '')
        logger.debug "environment_str = #{environment_str}"
        if environment = Environment.where("name ilike '#{environment_str}' or shortname ilike '#{environment_str}'").first
          self.environment = environment
        end
      end
    end
  end

  private

  def add_when
    self.when ||= Time.zone.now
  end

  def tagify
    payload = self.title + ' '
    payload += self.description unless self.description.nil?
    hashtags = payload.scan(/#(\w+)/).flatten
    tags = hashtags.uniq.map do |hashtag|
      Tag.where(name: hashtag.downcase.strip).first_or_create!
    end
    self.tags = tags
  end

  def send_notifications
    Notification.where(on_new_change: true).each do |notification|
      unless notification.user == self.entered_by
        Emailer.new_change(notification.user, self).deliver_later
      end
    end
  end

  def setup_subscriptions
    self.subscriptions.build({user: self.entered_by}).save
    unless self[:poc] == self.entered_by
      self.subscriptions.build({user_id: self[:poc_id]}).save
    end
  end

end
