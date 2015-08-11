class Certificate < ActiveRecord::Base

  # Validations
  validates_presence_of :pem
  validates_uniqueness_of :pem

  # Automatic Actions
  before_save :parse_certificate

  # Scopes
  scope :sorted, -> { order(:not_after) }
  scope :expires_soon, -> { where('not_after <= ?', 90.days.from_now) }
  scope :expired, -> { where('not_after < ?', Date.today) }

  def expires_soon
    not_after <= 90.days.from_now
  end

  def expired
    not_after < Date.today
  end

  private

  def parse_certificate
    require 'openssl'
    ssl = OpenSSL::X509::Certificate.new(self.pem)
    self.issuer = ssl.issuer.to_s
    self.key_length = ssl.public_key.n.num_bits
    self.not_before = ssl.not_before
    self.not_after = ssl.not_after
    self.signature_algorithm = ssl.signature_algorithm
    self.subject = ssl.subject.to_s
    self.cn = self.subject.split('/').select{ |v| v =~ /^CN=/ }.first.split('=').last
    self.modulus = ssl.public_key.n.to_s(16)
  end

end
