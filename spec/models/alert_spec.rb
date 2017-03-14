# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Alert, type: :model do
  it 'creates a valid object' do
    expect(build(:alert)).to be_valid
  end

  it 'is invalid without a :list' do
    expect(build(:alert, list: nil)).not_to be_valid
  end

  it 'is invalid if :list is not a List' do
    expect{build(:alert, list: build(:tag))}.to raise_error
  end

  describe 'operator' do
    it 'is valid with a valid operator' do
      expect(build(:alert, operator: '==')).to be_valid
    end

    it 'is invalid with a bad operator' do
      expect(build(:alert, operator: '123')).not_to be_valid
    end
  end
end
