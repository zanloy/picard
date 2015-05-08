require 'rails_helper'

RSpec.describe WebhooksController, type: :controller do

  let(:good_slack_payload) {
    {
      token: 'eKLjCtS6I102bLvvjPV0RYXt',
      user_name: 'Zan Tester',
      text: 'picard add This is a new change!',
      trigger_word: 'picard',
    }
  }

  let(:bad_slack_payload) {
    {
      token: '',
      user_name: 'Zan Tester',
      text: 'picard add This is a new change!',
      trigger_word: 'picard',
    }
  }

  describe 'POST #slack' do
    it 'validates the token'
    describe 'responds to add action' do
      it 'adds a change corrently' do
        post :slack, good_slack_payload
        expect(response.body).to match /Success/
      end
      it 'is invalid with a bad or missing token' do
        post :slack, bad_slack_payload
        expect(response.body).to match /Bad or missing token/
      end
      it 'is invalid with bad syntax'
    end
  end

end
