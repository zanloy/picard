# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Alert, type: :model do
  context 'validations' do
    subject { build(:alert) }

    it { should validate_presence_of :list }
  end

  it 'is invalid if :list is not a List' do
    expect { build(:alert, list: build(:tag)) } .to raise_error ActiveRecord::AssociationTypeMismatch
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
