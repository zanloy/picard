class Tagging < ActiveRecord::Base

  belongs_to :log_item
  belongs_to :tag

end
