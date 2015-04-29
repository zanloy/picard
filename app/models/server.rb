class Server < ActiveRecord::Base

  # Associations
  belongs_to :environment

  # Validation
  validates_presence_of :name

  def fqdn
    return self.name if self.environment.nil?
    return self.name if self.environment.domain.nil? or self.environment.domain.empty?
    return "#{self.name}.#{self.environment.domain}"
  end

end
