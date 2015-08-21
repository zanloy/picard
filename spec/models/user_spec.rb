require 'rails_helper'

RSpec.describe User, type: :model do
  it 'creates a valid user' do
    expect(build(:user)).to be_valid
  end

  it 'is invalid without a name' do
    expect(build(:user, name: nil)).not_to be_valid
  end

  it 'is invalid without an email address' do
    expect(build(:user, email: nil)).not_to be_valid
  end

  it 'is invalid without a unique email address' do
    create(:user, email: 'test@test.com')
    expect(build(:user, email: 'test@test.com')).not_to be_valid
  end

  context 'on create' do
    it 'downcases email address' do
      user = create(:user, email: 'this@That.com')
      expect(user.email).to eql('this@that.com')
    end
    it 'starts disabled' do
      user = User.new
      expect(user.enabled).to eql(false)
    end
    it 'is not banned' do
      user = User.new
      expect(user.banned).to eql(false)
    end
    it 'creates a profile' do
      expect{create(:user)}.to change {Profile.count}.by(1)
    end
    it 'creates notifications' do
      expect{create(:user)}.to change {Notification.count}.by(1)
    end
  end

  context 'on destroy' do
    before(:each) { @user = create(:user) }
    it 'destroys profile' do
      expect{@user.destroy}.to change {Profile.count}.by(-1)
    end
    it 'destroys notifications' do
      expect{@user.destroy}.to change {Notification.count}.by(-1)
    end
    it 'destroys subscriptions' do
      change = create(:engineering_change)
      create(:subscription, subscribable: change, user: @user)
      expect{@user.destroy}.to change {Subscription.count}.by(-1)
    end
    it 'nullifies associated changes' do
      change = create(:engineering_change, poc_id: @user.id)
      @user.destroy
      change.reload
      expect(change.poc_id).to be_nil
    end
  end

  context 'scopes' do
    it '#sorted returns a sorted list of users' do
      user1 = create(:user, name: 'Muhammed Ali')
      user2 = create(:user, name: 'Alfred Pennyworth')
      user3 = create(:user, name: 'Jeremiah Johnson')
      expect(User.sorted).to eq([user2, user3, user1])
    end
    it '#enabled returns a list of enabled users' do
      user1 = create(:user)
      user2 = create(:user, :disabled)
      user3 = create(:user)
      expect(User.enabled).to match_array([user1, user3])
    end
  end

  describe '#enabled?' do
    it 'returns false for a new User' do
      user = User.new
      expect(user.enabled?).to eql(false)
    end
    it 'returns true for an enabled user' do
      expect(build(:user).enabled?).to eql(true)
    end
    it 'returns false for a banned user' do
      expect(build(:user, :banned).enabled?).to eql(false)
    end
  end

  describe '#name_or_email' do
    it 'returns email if no name' do
      expect(build(:user, name: nil, email: 'test@test.com').name_or_email).to eq('test@test.com')
    end
    it 'returns name if exists' do
      expect(build(:user, name: 'Tester Testington').name_or_email).to eq('Tester Testington')
    end
  end
end
