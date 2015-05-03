require 'rails_helper'

RSpec.describe EngineeringChange, type: :model do

  it 'has a valid change' do
    expect(build(:engineering_change)).to be_valid
  end

  it 'is invalid without a date' do
    expect(build(:engineering_change, when: nil)).to_not be_valid
  end

  it 'is invalid without a title' do
    expect(build(:engineering_change, title: nil)).to_not be_valid
  end

  it 'is invalid with a title over 142 character' do
    long_title = (0..143).map { (65 + rand(26)).chr }.join
    expect(build(:engineering_change, title: long_title)).to_not be_valid
  end

  context 'on create' do
    before(:each) { @change = create(:engineering_change, title: 'This is a #test #change #reboot #test') }
    it 'creates tags' do
      expect(Tag.count).to eq(3)
    end
    it 'associates tags with this change' do
      expect(@change.taggings.count).to eq(3)
    end
  end

  context 'on destroy' do
    before(:each) do
      @user = create(:user)
      @change = create(:engineering_change)
    end
    it 'deletes associated subscriptions' do
      subscription = create(:subscription, subscribable: @change, user: @user)
      expect{@change.destroy}.to change {Subscription.count}.by(-1)
    end
    it 'deletes associated comments' do
      comment = create(:comment, commentable: @change, user: @user)
      expect{@change.destroy}.to change {Comment.count}.by(-1)
    end
  end

  describe '#has_description?' do
    it 'returns true if description exists' do
      expect(build(:engineering_change, description: 'Yes.').has_description?).to eq(true)
    end
    it 'returns false if no description exists' do
      expect(build(:engineering_change, description: nil).has_description?).to eq(false)
    end
  end

  describe '#has_comments?' do
    before(:each) { @change = create(:engineering_change) }
    it 'returns true if comments exist' do
      user = create(:user)
      create(:comment, commentable: @change, user: user)
      expect(@change.has_comments?).to eq(true)
    end
    it 'returns false if no comments exists' do
      expect(@change.has_comments?).to eq(false)
    end
  end

  describe '#subscription_for'

  describe '#subscribed?' do
    before(:each) do
      @user = create(:user)
      @change = create(:engineering_change)
    end
    it 'returns false if user is not subscribed' do
      expect(@change.subscribed?(@user.id)).to eq(false)
    end
    it 'returns true if user is subscribed' do
      create(:subscription, subscribable: @change, user: @user)
      expect(@change.subscribed?(@user.id)).to eq(true)
    end
  end

  describe '#tags_csv' do
    before(:each) { @change = create(:engineering_change, title: 'This is a #test #change #reboot #test') }
    it 'returns a csv with associated tags' do
      expect(@change.tags_csv).to eq('test, change, reboot')
    end
  end

end
