# frozen_string_literal: true
require 'rails_helper'

RSpec.describe List, type: :model do
  let(:list) { create(:list, name: 'Name', schema: '{ "cn":"string", "expires_on":"date" }') }

  context 'validations' do
    subject { build(:list, name: 'Name', schema: '{ "cn":"string", "expires_on":"date" }') }

    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end

  it 'is invalid if passed invalid json for payload' do
    expect { create(:list, schema: '{') } .to raise_error JSON::ParserError
  end

  describe '#parsed' do
    it 'returns valid JSON' do
      expect(list.parsed).to eql('cn' => 'string', 'expires_on' => 'date')
    end
  end

  describe '#fields' do
    it 'returns an array of keys' do
      expect(list.fields).to eql(%w(cn expires_on))
    end
  end
end
