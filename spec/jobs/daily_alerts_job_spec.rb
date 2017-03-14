# frozen_string_literal: true
require 'rails_helper'

RSpec.describe DailyAlertsJob, type: :job do

  include ActiveJob::TestHelper

  before(:each) do
    create(:user)
    create(:certificate)
    create(:certificate, :expired)
  end

  it 'performs the job' do
    DailyAlertsJob.new.perform
    expect(enqueued_jobs.size).to eq(1)
  end
end
