class Tagging < ActiveRecord::Base

  # Associations
  belongs_to :log_item
  belongs_to :tag

end
