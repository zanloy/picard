require 'rails_helper'

RSpec.describe Certificate, type: :model do
  it 'creates a valid object' do
    expect(build(:certificate)).to be_valid
  end

  it 'is invalid without a pem encoded cert' do
    expect(build(:certificate, pem: nil)).not_to be_valid
  end

  it 'is invalid if another pem is already in the db' do
    create(:certificate)
    expect(build(:certificate)).not_to be_valid
  end

  describe '#parse_certificate' do
    let (:cert) { create(:certificate) }
    it 'parses the subject' do
      expect(cert.subject).to eql('/C=US/ST=South Carolina/L=Charleston/O=Picard/CN=Picard Test Certificate')
    end

    it 'parses the issuer' do
      expect(cert.issuer).to eql('/C=US/ST=South Carolina/L=Charleston/O=Picard/CN=Picard Test Certificate')
    end

    it 'parses the not_before date' do
      expect(cert.not_before).to eql(Time.parse('Mon, 10 Aug 2015 14:16:39 EDT -04:00'))
    end

    it 'parses the not_after date' do
      expect(cert.not_after).to eql(Time.parse('Fri, 09 May 2025 14:16:39 EDT -04:00'))
    end

    it 'parses the key length' do
      expect(cert.key_length).to eql(2048)
    end
  end
end
