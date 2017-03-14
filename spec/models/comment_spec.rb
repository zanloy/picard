# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Comment, type: :model do
  # Validations
  it { should validate_presence_of :commentable_id }
  it { should validate_presence_of :commentable_type }
  it { should validate_presence_of :user }
  it { should validate_presence_of :comment }

  it 'creates a valid object' do
    expect(build(:comment)).to be_valid
  end

  context 'when tagged' do
    subject { create(:comment, comment: 'This is a #test with #tags') }
    it { expect(subject.tags.count).to eq(2) }
  end
end
