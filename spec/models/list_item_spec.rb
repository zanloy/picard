require 'rails_helper'

RSpec.describe ListItem, type: :model do

  let(:list_item) { build(:list_item, payload: %Q[{ "cn":"string", "expires_on":"date" }]) }

  it 'creates a valid object' do
    expect(list_item).to be_valid
  end

  it 'assigns the :list if a List is passed in' do
    list = create(:list)
    list_item = build(:list_item, list: list)
    expect(list_item.list).to eq(list)
  end

  it 'assigns the :list if :list_id is passed in' do
    list = create(:list)
    list_item = build(:list_item, list_id: list.id)
    expect(list_item.list).to eq(list)
  end

  it 'raises error if :list is not a List' do
    expect{create(:list_item, list: 'string')}.to raise_error
  end

  it 'is invalid without a payload' do
    expect{create(:list_item, payload: "{")}.to raise_error
  end

  describe '#parsed' do
    it 'returns a valid hash' do
      expect(list_item.parsed).to eql({'cn' => 'string', 'expires_on' => 'date'})
    end
  end

  describe '#fields' do
    it 'returns an array of keys' do
      expect(list_item.fields).to eq(['cn', 'expires_on'])
    end
  end

  it 'creates the meta field methods' do
    expect(list_item).to respond_to(:cn, :cn=, :expires_on, :expires_on=)
  end

end
