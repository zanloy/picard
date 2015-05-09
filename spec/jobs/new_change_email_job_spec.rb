require 'rails_helper'

RSpec.describe NewChangeEmailJob, type: :job do
  it 'sends an email to all subscribed on new job creation'
    #@users = create_pair(:user)
    #@users.each do |user|
    #  user.notification.on_new_change = true
    #  user.save
    #end
    #change = create(:engineering_change)
    #expect(Delayed::Worker.new.work_off).to eql([2,0]) # 2 success, 0 failures
end
