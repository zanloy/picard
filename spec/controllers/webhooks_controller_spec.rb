require 'rails_helper'

RSpec.describe WebhooksController, type: :controller do

  let(:slack_add_payload) {
    {
      token: 'eKLjCtS6I102bLvvjPV0RYXt',
      user_name: 'Zan Tester',
      text: 'picard add This is a new change!',
      trigger_word: 'picard',
    }
  }

  describe 'POST #slack' do
    describe 'responds to add action' do
      it 'adds a change corrently' do
        post :slack, slack_add_payload
        expect(response.body).to match /Success/
      end
      it 'is invalid with a bad or missing token' do
        bad_payload = slack_add_payload
        bad_payload[:token] = nil
        post :slack, bad_payload
        expect(response.body).to match /Bad or missing token/
      end
      it 'is invalid with bad syntax'
    end

    describe 'responds to list action' do
      it 'displays the latest changes' do
        changes = create_pair(:engineering_change)
        post :slack, { token: slack_add_payload[:token], text: 'picard list' }
        expect(response.body).to match changes.first[:title]
      end
    end
  end

end
