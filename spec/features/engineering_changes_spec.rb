require 'rails_helper'

RSpec.feature "Engineering Changes Management", type: :feature do
  feature 'adding new change' do
    sign_in

    scenario 'using quick add' do
      visit engineering_changes_path
      fill_in 'engineering_change_title', with: 'Reboot all the things!'
      fill_in 'Tags', with: 'reboot, things'
      click_on 'Quick Add'

      expect(current_path).to eq(engineering_changes_path)
      expect(page).to have_content('Reboot all the things!')
      expect(page).to have_content('reboot, things')
    end

    scenario 'using quick add with details' do
      visit engineering_changes_path
      fill_in 'engineering_change_title', with: 'Yum Updates'
      fill_in 'Tags', with: 'yum, rhel'
      click_on 'Add Details'

      expect(current_path).to eq(edit_engineering_change_path(EngineeringChange.last))
      expect(page).to have_selector("input[value='Yum Updates']")
      expect(page).to have_selector("input[value='rhel, yum']")
    end

    scenario 'using add new link' do
      visit new_engineering_change_path
      select @current_user.name, from: 'POC'
      fill_in 'Title', with: 'Update AV'
      fill_in 'Tags', with: 'av'
      click_on 'Create Engineering change'

      expect(current_path).to eq(engineering_change_path(EngineeringChange.last))
      expect(page).to have_content(@current_user.name)
      expect(page).to have_content('Update AV')
      expect(page).to have_content('av')
    end
  end
end
