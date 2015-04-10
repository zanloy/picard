class LogItem < ActiveRecord::Base

  belongs_to :entered_by, class_name: :user, foreign_key: :entered_by_id
  belongs_to :poc, class_name: :user, foreign_key: :poc_id
  belongs_to :environment
  has_many :taggings
  has_many :tags, through: :taggings

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(', ')
  end

end
