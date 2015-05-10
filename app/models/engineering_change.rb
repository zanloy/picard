class EngineeringChange < ActiveRecord::Base

  before_save :parse_title
  after_save :tagify
  after_save :validate_servers
  after_create :send_notifications, :notify_slack, :setup_subscriptions

  # Associations
  belongs_to :entered_by, class_name: User
  belongs_to :poc, class_name: User
  belongs_to :environment
  has_many :affections, as: :affectable, autosave: true
  has_many :servers, through: :affections, autosave: true
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
    if in_position = words.index('in')
      environment_str = words[in_position + 1]
      logger.debug "environment_str = #{environment_str}"
      if environment = Environment.where("name ilike '#{environment_str}'").first
        self.environment = environment
      end
    end
    ## Setup affects for tagged servers
    #hashtags = words.select { |w| w[0] == '#' }
    #hashtags.each do |hashtag|
    #  hashtag[0] = ''
    #  if server = Server.find_by_name(hashtag)
    #    logger.debug "Found server with name #{hashtag} for change #{self.id}"
    #    self.servers << server
    #  end
    #end
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
      hashtag[0] = ''
      if server = Server.where(environment: self.environment, name: hashtag.downcase.strip).first
        self.servers << server
      end
      Tag.where(name: hashtag.downcase.strip).first_or_create!
    end
    logger.debug "tags = #{tags.inspect}"
    self.tags = tags
  end

  def send_notifications
    Notification.where(on_new_change: true).each do |notification|
      if notification.user != self.entered_by
        NewChangeEmailJob.set(wait: 20.seconds).perform_later(notification.user, self)
      end
    end
  end

  def setup_subscriptions
    begin
      @change.subscriptions.build({user_id: @current_user[:id]}).save
      if @change[:poc_id] != @current_user[:id]
        @change.subscriptions.build({user_id: @change[:poc_id]}).save
      end
    rescue
    end
  end
  
  def notify_slack
    begin
      if ENV['SLACK_WEBHOOK']
        notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK'], channel: ENV['SLACK_CHANNEL'], username: 'Jean-Luc Picard'
        if ENV['SLACK_ICON_URL']
          notifier.ping "New Change: #{view_context.link_to(@change.title, engineering_change_url(@change))}", icon_url: view_context.asset_url('img/picard_avatar.png')
        else
          notifier.ping "New Change: #{view_context.link_to(@change.title, engineering_change_url(@change))}", icon_emoji: ':shipit:'
        end
      end
    rescue => e
      logger.debug e
    end
  end

  def validate_servers
    if self.environment
      self.servers = self.servers.where(environment_id: self.environment.id)
    end
  end
end
