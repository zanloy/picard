# frozen_string_literal: true
class Subscription < ActiveRecord::Base

  # Associations
  belongs_to :subscribable, polymorphic: true
  belongs_to :user

  # Validations
  validates_presence_of :subscribable_id, :subscribable_type, :user_id

end
