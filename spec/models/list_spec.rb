require 'rails_helper'

RSpec.describe List, type: :model do

  let(:list) { create(:list, name: 'Name', schema: %Q[{ "cn":"string", "expires_on":"date" }]) }

  it 'creates a valid object' do
    expect(list).to be_valid
  end

  it 'is invalid without a name' do
    expect{create(:list, name: nil)}.to raise_error
  end

  it 'is invalid if name already exists' do
    create(:list, name: 'Name')
    expect{create(:list, name: 'Name')}.to raise_error
  end

  it 'is invalid if passed invalid json for payload' do
    expect{create(:list, schema: "{")}.to raise_error
  end

  describe '#parsed' do
    it 'returns valid JSON' do
      expect(list.parsed).to eql({"cn" => "string", "expires_on" => "date"})
    end
  end

  describe '#fields' do
    it 'returns an array of keys' do
      expect(list.fields).to eql(['cn', 'expires_on'])
    end
  end

end
