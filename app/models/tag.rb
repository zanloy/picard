class Tag < ActiveRecord::Base

  include FriendlyId
  friendly_id :name, use: :finders

  # Associations
  has_many :taggings
  has_many :engineering_changes, through: :taggings

  # Validation
  validates_presence_of :name
  validates_uniqueness_of :name

  before_save :normalize

  def to_param
    name
  end

  def self.find(name)
    self.find_by! name: name
  end

  private

  def normalize
    self.name = self.name.downcase
    self.name = self.name.gsub(/[^0-9a-z ]/i, '')
  end

end
