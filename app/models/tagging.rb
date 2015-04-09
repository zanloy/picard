class Tagging < ActiveRecord::Base

  belongs_to :change
  belongs_to :tag

end
