class Subscription < ActiveRecord::Base

  # Associations
  belongs_to :subscribable, polymorphic: true
  belongs_to :user
  
  # Validations
  validates_presence_of :user_id

end
