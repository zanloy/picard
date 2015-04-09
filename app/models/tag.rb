class Tag < ActiveRecord::Base

  has_many :taggings
  has_many :log_items, through: :taggings

end
