require 'rails_helper'

RSpec.feature "Engineering Changes Management", type: :feature do
  #before(:each) { sign_in }
  feature 'adding new change' do
    sign_in

    scenario 'using quickadd' do
      visit engineering_changes_path
      fill_in 'engineering_change_title', with: 'Reboot all the things!'
      fill_in 'Tags', with: 'reboot, things'
      click_on 'Quick Add'

      expect(page).to have_content('Reboot all the things!')
    end

    scenario 'using add new link' do
      visit new_engineering_change_path
      select @user.name, from: 'POC'
      fill_in 'Title', with: 'Update AV'
      click_on 'Create Engineering change'

      expect(page).to have_content('Update AV')
    end
  end
end
