require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'creates a valid Tag' do
    expect(build(:tag)).to be_valid
  end
  it 'is invalid without a name' do
    expect(build(:tag, name: nil)).not_to be_valid
  end
  it 'is invalid if a duplicate name' do
    create(:tag, name: 'allyourbase')
    expect(build(:tag, name: 'allyourbase')).not_to be_valid
  end
end
