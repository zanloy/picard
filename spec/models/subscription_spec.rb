# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Subscription, type: :model do
  before(:each) do
    @user = create(:user)
    @change = create(:engineering_change)
  end
  it 'creates a valid Subscription' do
    expect(build(:subscription, subscribable: @change, user: @user)).to be_valid
  end
  it 'is invalid without a subscribable' do
    expect(build(:subscription, subscribable: nil, user: @user)).not_to be_valid
  end
  it 'is invalid without a user' do
    expect(build(:subscription, subscribable: @change, user: nil)).not_to be_valid
  end
end
