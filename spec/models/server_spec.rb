# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Server, type: :model do

  it 'creates a valid object' do
    expect(build(:server)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:server, name: nil)).not_to be_valid
  end

  it 'generates an api key' do
    expect(create(:server).api_key).not_to be_nil
  end

end
