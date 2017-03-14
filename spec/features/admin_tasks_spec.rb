# frozen_string_literal: true
require 'rails_helper'

RSpec.feature 'Admin Tasks', type: :feature do
  feature 'responding a new user request' do
    sign_in(:admin)

    before(:each) { @disabled_user = create(:user, :disabled) }

    scenario 'enabling the user' do
      visit admin_path
      click_on "enable_user_#{@disabled_user.id}"
      @disabled_user.reload
      expect(@disabled_user.enabled).to eq(true)
    end

    scenario 'deleting the user' do
      visit admin_path
      click_on "delete_user_#{@disabled_user.id}"
      expect{@disabled_user.reload}.to raise_exception
    end
  end
end
