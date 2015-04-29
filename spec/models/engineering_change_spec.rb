require 'rails_helper'

RSpec.describe EngineeringChange, type: :model do
  it 'has a valid change' do
    expect(build(:engineering_change)).to be_valid
  end
  it 'is invalid without a date' do
    expect(build(:engineering_change, when: nil)).to_not be_valid
  end
  it 'is invalid without a title' do
    expect(build(:engineering_change, title: nil)).to_not be_valid
  end
  it 'is invalid with a title over 142 character' do
    long_title = (0..143).map { (65 + rand(26)).chr }.join
    expect(build(:engineering_change, title: long_title)).to_not be_valid
  end
  describe '#has_description?' do
    it 'returns true if description exists' do
      expect(build(:engineering_change, description: 'Yes.').has_description?).to eq(true)
    end
    it 'returns false if no description exists' do
      expect(build(:engineering_change, description: nil).has_description?).to eq(false)
    end
  end
  describe '#has_comments?' do
    it 'returns true if comments exist'
    it 'returns false if no comments exists'
  end
  describe '#subscription_for'
  describe '#subscribed?' do
    it 'returns true if user is subscribed'
    it 'returns false if user is not subscribed'
  end
  describe '#all_tags=' do
    it 'creates tags for all values in comma separated string'
    it 'associates all tags with this change'
  end
  describe '#all_tags' do
    it 'returns a comma separated list of associated tags'
  end
end
