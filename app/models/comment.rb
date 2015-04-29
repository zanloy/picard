class Comment < ActiveRecord::Base

  # Associations
  belongs_to :commentable, polymorphic: true
  belongs_to :user

  # Validation
  validates_presence_of :commentable_id, :commentable_type, :user_id, :comment

end
