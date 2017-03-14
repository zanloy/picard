# frozen_string_literal: true
require 'rails_helper'

RSpec.describe Comment, type: :model do

  it 'creates a valid object' do
    expect(build(:comment)).to be_valid
  end

  it 'is invalid without a commentable object' do
    expect(build(:comment, commentable: nil)).not_to be_valid
  end

  it 'is invalid without a user' do
    expect(build(:comment, user: nil)).not_to be_valid
  end

  it 'is invalid without a comment' do
    expect(build(:comment, comment: nil)).not_to be_valid
  end

  context 'when tagged' do
    subject { create(:comment, comment: 'This is a #test with #tags') }
    it { expect(subject.tags.count).to eq(2) }
  end
end
