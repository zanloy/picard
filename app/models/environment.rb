class Environment < ActiveRecord::Base

  # Associations
  has_many :engineering_changes, dependent: :nullify
  has_many :servers, dependent: :destroy

  # Validation
  validates_presence_of :name

end
