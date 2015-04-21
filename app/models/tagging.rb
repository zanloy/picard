class Tagging < ActiveRecord::Base

  # Associations
  belongs_to :engineering_change
  belongs_to :tag

end
