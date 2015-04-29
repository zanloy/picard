class EngineeringChange < ActiveRecord::Base

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

  def all_tags=(names)
    names = names.split(',').map { |x| x.strip }.uniq
    self.tags = names.map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(', ')
  end

end
