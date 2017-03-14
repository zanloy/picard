# frozen_string_literal: true
require 'rails_helper'

feature 'User signs up' do
  scenario 'with valid credentials' do
    visit signup_path
    fill_in 'Name', with: FFaker::Name.name
    fill_in 'Email', with: FFaker::Internet.email
    fill_in 'Password', with: '1qazxsw2#EDCVFR$'
    click_on 'Create User'

    expect(page).to have_content('Account Disabled')
  end

  context 'with invalid credentials' do
    scenario 'without an email' do
      visit signup_path
      fill_in 'Name', with: FFaker::Name.name
      fill_in 'Password', with: '1qazxsw2#EDCVFR$'
      click_on 'Create User'

      expect(page).to have_content("can't be blank")
    end

    scenario 'without a name' do
      visit signup_path
      fill_in 'Email', with: FFaker::Internet.email
      fill_in 'Password', with: '1qazxsw2#EDCVFR$'
      click_on 'Create User'

      expect(page).to have_content("can't be blank")
    end

    scenario 'with a weak password' do
      visit signup_path
      fill_in 'Email', with: FFaker::Internet.email
      fill_in 'Password', with: 'test'
      fill_in 'Name', with: FFaker::Name.name
      click_on 'Create User'

      expect(page).to have_content('is too weak')
    end
  end
end

feature 'user signs in' do
  scenario 'with valid credentials' do
    user = create(:user, new_password: '1qazxsw2#EDCVFR$')
    visit signin_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: '1qazxsw2#EDCVFR$'
    click_on 'Sign in'

    expect(page).to have_content("Signed in as #{user.name}")
  end

  scenario 'with invalid credentials' do
    visit signin_path
    fill_in 'Email', with: 'test@test.com'
    fill_in 'Password', with: 'P@$$w0rd'
    click_on 'Sign in'

    expect(page).to have_content('Login failed.')
  end
end
