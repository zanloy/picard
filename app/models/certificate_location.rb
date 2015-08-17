class CertificateLocation < ActiveRecord::Base
  belongs_to :server
  belongs_to :certificate
end
