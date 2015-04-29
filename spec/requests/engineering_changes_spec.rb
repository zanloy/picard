require 'rails_helper'

RSpec.describe "EngineeringChanges", type: :request do
  describe "GET /engineering_changes" do
    it 'displays the tasks' do
      visit engineering_changes_path
      page.should have_content 'Restarted all servers!'
    end
  end
end
