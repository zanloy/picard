# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Certificate, type: :model do
  describe 'the scope .expired' do
    it 'lists only expired certs' do
      create(:certificate)
      expired_cert = create(:certificate, :expired)
      expect(Certificate.expired).to match_array([expired_cert])
    end
  end

  describe '#expires_soon' do
    before(:each) { @cert = create(:certificate) }
    it 'is false for valid certs' do
      expect(@cert.expires_soon).to eql(false)
    end

    it 'is true for certs expiring soon' do
      @cert.not_after = 45.days.from_now
      expect(@cert.expires_soon).to eql(true)
    end
  end

  describe '#expired' do
    it 'is false for valid certs' do
      cert = create(:certificate)
      expect(cert.expired).to eql(false)
    end

    it 'is true for expired certs' do
      cert = create(:certificate, :expired)
      expect(cert.expired).to eql(true)
    end
  end

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
    let(:cert) { create(:certificate) }

    it 'parses the subject' do
      expect(cert.subject).to eql('/C=US/ST=South Carolina/L=Charleston/O=Picard/CN=Picard Test Certificate')
    end

    it 'parses the cn' do
      expect(cert.cn).to eql('Picard Test Certificate')
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

    it 'parses the modulus' do
      expect(cert.modulus).to eql('EDB3E1E51F9F33312497E4A55E17850232566FD14A35CD949CCA73E60FEF8576A607AE6E0C403A3B09B321953ACB8E7BB6115F4FCD610DB8E5C5F139EBB482795453AD8FD28856009E4EDB3FFB88E6A7EE513049443C353A16E2D953FD149B0BEAF59BE102B5605D77B1FCE9937BA189CBC349BFDAC5CE3461DFA018123EBB85AC25F70778A0E4F6AE5C9A15ECA57F97B810028D58DB873337D343F9EE8833904782CC326DCD7E42AC0ED3383FC2A04E05BFA162CA9EF428F8F8DD99D4940A9866EF3E364357617F407EBA2497A991638D0EA5207DEDA4B70F0BCDB5100E762B736260F7E84CCC30DBECC6FCA339A20A4288EDED3A0B3E8BBA8BA7C8DA18F2AD')
    end
  end
end
