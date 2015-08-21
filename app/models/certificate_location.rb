class CertificateLocation < ActiveRecord::Base

  # Associations
  belongs_to :server
  belongs_to :certificate, counter_cache: :locations_count

  # Validations
  validates_presence_of :server, :certificate

end
