require 'rails_helper'

RSpec.describe "TwoWords", type: :request do
  describe "GET /two_words" do
    it "works! (now write some real specs)" do
      get two_words_path
      expect(response).to have_http_status(200)
    end
  end
end
