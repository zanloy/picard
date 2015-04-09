require 'rails_helper'

RSpec.describe "LogItms", type: :request do
  describe "GET /log_itms" do
    it "works! (now write some real specs)" do
      get log_itms_path
      expect(response).to have_http_status(200)
    end
  end
end
