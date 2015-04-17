class LogItem < ActiveRecord::Base

  belongs_to :entered_by, class_name: User
  belongs_to :poc, class_name: User
  belongs_to :environment
  has_many :taggings
  has_many :tags, through: :taggings

  scope :timeline, -> { order(when: :desc) }

  def has_description?
    if self.description.nil? or self.description.empty?
      return false
    else
      return true
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
