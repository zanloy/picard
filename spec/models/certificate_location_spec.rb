# frozen_string_literal: true
require 'rails_helper'

RSpec.describe CertificateLocation, type: :model do
  it 'creates a valid object' do
    expect(build(:certificate_location)).to be_valid
  end

  it 'is invalid without a server' do
    expect(build(:certificate_location, server: nil)).not_to be_valid
  end

  it 'is invalid without a certificate' do
    expect(build(:certificate_location, certificate: nil)).not_to be_valid
  end
end
