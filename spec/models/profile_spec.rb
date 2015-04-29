require 'rails_helper'

RSpec.describe Profile, type: :model do
  it 'created profile automatically' do
    expect{create(:user)}.to change {Profile.count}.by(1)
  end
end
