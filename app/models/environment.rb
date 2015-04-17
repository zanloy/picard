class Environment < ActiveRecord::Base

  has_many :servers
  has_many :log_items

  scope :has_servers, -> { select { |env| env.servers.count >= 1 } }
  
end
