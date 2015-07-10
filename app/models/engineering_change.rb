class EngineeringChange < ActiveRecord::Base

  before_save :parse_title
  after_save :tagify
  after_create :send_notifications, :notify_slack, :setup_subscriptions

  # Associations
  belongs_to :entered_by, class_name: User
  belongs_to :poc, class_name: User
  belongs_to :environment
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :comments, as: :commentable, dependent: :destroy
  has_many :subscriptions, as: :subscribable, dependent: :destroy

  # Scopes
  scope :timeline, -> { order(when: :desc) }

  # Validation
  validates_presence_of :when, :title
  validates_length_of :title, maximum: 142

  self.per_page = 15

  def has_description?
    if self.description.nil? or self.description.empty?
      return false
    else
      return true
    end
  end

  def has_comments?
    if self.comments.count > 0
      return true
    else
      return false
    end
  end

  def subscription_for(id)
    self.subscriptions.find_by_user_id(id)
  end

  def subscribed?(id)
    if self.subscription_for(id)
      return true
    else
      return false
    end
  end

  #def all_tags=(names)
  #  names = names.split(',').map { |x| x.strip }.uniq
  #  self.tags = names.map do |name|
  #    Tag.where(name: name.strip).first_or_create!
  #  end
  #end

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

  def affects?(server)
    if self.affections.where(server_id: server.id).count != 0
      return true
    else
      return false
    end
  end

  private

  def tagify
    words = self.title.split
    words += self.description.split if self.description != nil
    hashtags = words.select { |word| word[0] == '#' }
    tags = hashtags.uniq.map do |hashtag|
      hashtag.gsub!(/[^a-zA-Z0-9]/, '')
      Tag.where(name: hashtag.downcase.strip).first_or_create!
    end
    logger.debug "tags = #{tags.inspect}"
    self.tags = tags
  end

  def send_notifications
    Notification.where(on_new_change: true).each do |notification|
      unless notification.user == self.entered_by
        NewChangeEmailJob.set(wait: 20.seconds).perform_later(notification.user, self)
      end
    end
  end

  def setup_subscriptions
    self.subscriptions.build({user: self.entered_by}).save
    unless self[:poc] == self.entered_by
      self.subscriptions.build({user_id: self[:poc_id]}).save
    end
  end

  def notify_slack
    begin
      if ENV.has_key? 'SLACK_WEBHOOK'
        notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK'], channel: '#general', username: 'Jean-Luc Picard'
        notifier.ping "New Change: #{view_context.link_to(self.title, engineering_change_url(self))}"
      end
    rescue
    end
  end

end
