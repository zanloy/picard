require 'rails_helper'

RSpec.describe DailyAlertsJob, type: :job do
  before(:each) do
    create(:user)
    create(:certificate)
    create(:certificate, :expired)
  end

  it 'performs the job' do
    DailyAlertsJob.new.perform
    expect(Delayed::Worker.new.work_off).to eql([1,0])
  end
end
