class Environment < ActiveRecord::Base

  # Associations
  has_many :engineering_changes, dependent: :nullify

  # Validation
  validates_presence_of :name

end
