require 'rails_helper'

RSpec.describe Environment, type: :model do

  it 'has a valid environment' do
    expect(build(:environment)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:environment, name: nil)).to_not be_valid
  end

  subject { create(:environment) }

end
