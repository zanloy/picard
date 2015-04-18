class Server < ActiveRecord::Base

  belongs_to :environment

  def fqdn
    if self.environment.domain.nil?
      return self.name
    else
      return "#{self.name}.#{self.environment.domain}"
    end
  end
  
end
