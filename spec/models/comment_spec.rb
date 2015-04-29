require 'rails_helper'

RSpec.describe Comment, type: :model do

  let(:user) { create(:user) }
  let(:commentable) { create(:engineering_change) }

  it 'creates a valid object' do
    expect(build(:comment, commentable: commentable, user: user)).to be_valid
  end

  it 'is invalid without a commentable object' do
    expect(build(:comment, commentable: nil, user: user)).not_to be_valid
  end

  it 'is invalid without a user' do
    expect(build(:comment, commentable: commentable, user: nil)).not_to be_valid
  end

  it 'is invalid without a comment' do
    expect(build(:comment, commentable: commentable, user: user, comment: nil)).not_to be_valid
  end

end
