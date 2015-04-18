class LogItem < ActiveRecord::Base

  # Associations
  belongs_to :entered_by, class_name: User
  belongs_to :poc, class_name: User
  belongs_to :environment
  has_many :taggings
  has_many :tags, through: :taggings
  has_many :comments, as: :commentable
  has_many :subscriptions, as: :subscribable

  # Scopes
  scope :timeline, -> { order(when: :desc) }

  # Validation
  validates_presence_of :when, :name
  validates_length_of :name, maximum: 140

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

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(', ')
  end

end
