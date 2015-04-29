require 'rails_helper'

RSpec.describe Server, type: :model do

  it 'has creates a valid server' do
    expect(build(:server)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:server, name: nil)).to_not be_valid
  end

  describe '#fqdn' do
    it 'returns the server name if no associated environment domain' do
      server = build(:server)
      expect(server.fqdn).to eq(server.name)
    end
    it 'returns the fqdn if associated environment has a domain' do
      env = create(:environment, domain: 'test.com')
      expect(build(:server, name: 'proxy', environment: env).fqdn).to eq('proxy.test.com')
    end
  end

end
