require 'rails_helper'

RSpec.describe NewChangeEmailJob, type: :job do

  before(:each) { Delayed::Worker.delay_jobs = false }

  it 'sends an email to all subscribed users on new change creation'
  #it 'sends an email to all subscribed users on new change creation' do
  #  @users = create_pair(:user)
  #  @users.each do |user|
  #    user.notification.on_new_change = true
  #    user.notification.save
  #  end
  #  change = create(:engineering_change)
  #  expect(Delayed::Worker.new.work_off).to eq([2,0]) # 2 success, 0 failures
  #end
end
