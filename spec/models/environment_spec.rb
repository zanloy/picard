require 'rails_helper'

RSpec.describe Environment, type: :model do

  it 'has a valid environment' do
    expect(build(:environment)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:environment, name: nil)).to_not be_valid
  end

  subject { create(:environment) }

  context 'scopes' do
    describe '#has_servers' do
      it 'returns nothing if no servers are associated' do
        expect(Environment.has_servers).to be_empty
      end
      it 'returns an array of environments if servers are associated' do
        10.times.each { create(:server, environment: subject) }
        expect(Environment.has_servers).to eq([subject])
      end
    end
  end

end
