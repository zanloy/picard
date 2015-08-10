class Certificate < ActiveRecord::Base

  # Validations
  validates_presence_of :pem
  validates_uniqueness_of :pem

  # Automatic Actions
  before_save :parse_certificate

  private

  def parse_certificate
    puts "Parse Certificate Called."
    require 'openssl'
    ssl = OpenSSL::X509::Certificate.new(self.pem)
    self.issuer = ssl.issuer.to_s
    self.key_length = ssl.public_key.n.num_bits
    self.not_before = ssl.not_before
    self.not_after = ssl.not_after
    self.signature_algorithm = ssl.signature_algorithm
    self.subject = ssl.subject.to_s
  end

end
