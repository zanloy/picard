class Tagging < ActiveRecord::Base

  # Associations
  belongs_to :taggable, polymorphic: true
  belongs_to :tag

end
