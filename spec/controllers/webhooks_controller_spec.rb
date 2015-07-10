require 'rails_helper'

RSpec.describe WebhooksController, type: :controller do

  let(:slack_add_payload) {
    {
      token: 'test',
      user_name: 'tester',
      text: 'picard add This is a new change!',
      trigger_word: 'picard',
    }
  }

  before(:each) { @user = create(:user) }

  describe 'POST #slack' do
    describe 'responds to add action' do
      it 'adds a change corrently' do
        post :slack, slack_add_payload
        expect(response.body).to match /Success/
      end
      #it 'is invalid with a bad or missing token' do
      #  slack_add_payload[:token] = nil
      #  post :slack, slack_add_payload
      #  expect(response.body).to match /Bad or missing token/
      #end
      it 'is invalid without a matching username' do
        slack_add_payload[:user_name] = 'qwerty'
        post :slack, slack_add_payload
        expect(response.body).to match /No matching username in database/
      end
    end

    describe 'responds to list action' do
      it 'displays the latest changes' do
        changes = create_pair(:engineering_change)
        post :slack, { token: slack_add_payload[:token], text: 'picard list', trigger_word: 'picard' }
        expect(response.body).to match changes.first[:title]
        expect(response.body).to match changes.last[:title]
      end
    end
  end

end
