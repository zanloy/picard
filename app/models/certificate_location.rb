class CertificateLocation < ActiveRecord::Base

  # Associations
  belongs_to :server
  belongs_to :certificate

  # Validations
  validates_presence_of :server, :certificate
  
end
