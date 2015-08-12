require 'rails_helper'

RSpec.describe Tag, type: :model do
  it 'creates a valid Tag' do
    expect(build(:tag)).to be_valid
  end
  it 'is invalid without a name' do
    expect(build(:tag, name: nil)).not_to be_valid
  end
  ## This is commented out because it is hard to test with the factory using
  ## Tag.find_or_create_by. It will not error because it doesn't try to create
  ## a new tag.
  #it 'is invalid if a duplicate name' do
  #  create(:tag, name: 'allyourbase')
  #  expect{create(:tag, name: 'allyourbase')}.to raise_error
  #end
end
