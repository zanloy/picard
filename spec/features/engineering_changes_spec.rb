# frozen_string_literal: true
require 'rails_helper'

RSpec.feature "Engineering Changes Management", type: :feature do
  feature 'adding new change' do
    sign_in

    scenario 'using quick add' do
      visit engineering_changes_path
      fill_in 'engineering_change_title', with: 'Reboot all the things!'
      click_on 'Quick Add'

      expect(current_path).to eq(engineering_changes_path)
      expect(page).to have_content('Reboot all the things!')
    end

    scenario 'using quick add with details' do
      visit engineering_changes_path
      fill_in 'engineering_change_title', with: 'Yum Updates'
      click_on 'Add Details'

      expect(current_path).to eq(engineering_changes_path)
      expect(page).to have_selector("input[value='Yum Updates']")
    end

    scenario 'using add new link' do
      visit new_engineering_change_path
      select @current_user.name, from: 'POC'
      fill_in 'Title', with: 'Update AV'
      click_on 'Create Engineering change'

      expect(current_path).to eq(engineering_change_path(EngineeringChange.last))
      expect(page).to have_content(@current_user.name)
      expect(page).to have_content('Update AV')
    end
  end
end
