require 'rails_helper'

feature 'User signs up' do
  scenario 'with valid credentials' do
    visit signup_path
    fill_in 'Email', with: FFaker::Internet.email
    fill_in 'New password', with: '1qazxsw2#EDCVFR$'
    fill_in 'Name', with: FFaker::Name.name
    click_on 'Create User'

    expect(page).to have_content('Account Disabled')
  end

  scenario 'with invalid credentials' do
    visit signup_path
    fill_in 'Email', with: FFaker::Internet.email
    fill_in 'New password', with: 'test'
    fill_in 'Name', with: FFaker::Name.name
    click_on 'Create User'

    expect(page).to have('.form-with-error')
  end
end
