class Tag < ActiveRecord::Base

  # Associations
  has_many :taggings
  has_many :log_items, through: :taggings

  # Validation
  validates_presence_of :name
  validates_uniqueness_of :name

  before_save :normalize

  private

  def normalize
    self.name = self.name.downcase
    self.name = self.name.gsub(/[^0-9a-z ]/i, '')
  end

end
