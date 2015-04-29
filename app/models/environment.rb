class Environment < ActiveRecord::Base

  # Associations
  has_many :servers, dependent: :destroy
  has_many :engineering_changes, dependent: :nullify

  # Validation
  validates_presence_of :name

  # Scopes
  scope :has_servers, -> { select { |env| env.servers.count >= 1 } }
  scope :has_no_servers, -> { select { |env| env.servers.count == 0 } }

end
