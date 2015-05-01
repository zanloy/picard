require 'rails_helper'

RSpec.describe 'engineering_changes/_table', type: :view do

  before(:each) {
    @current_user = create(:user)
    assign(:current_user, @current_user)
    @environment = create(:environment)
    @changes = create_pair(:engineering_change, poc_id: @current_user.id, environment_id: @environment.id)
    assign(:changes, @changes)
    render partial: 'table'
  }

  describe 'rendering the partial' do
    it 'renders all records in a table' do
      @changes.each do |change|
        assert_select 'tr' do
          assert_select 'td', text: change.environment.name
          assert_select 'td', text: change.title
          assert_select 'td', text: change.poc.name
        end
      end
    end

    it 'displays the POC name' do
      expect(rendered).to match @current_user.name
    end

    it 'displays the change title' do
      expect(rendered).to match @changes.first.title
    end

    it 'contains a link to the change' do
      expect(rendered).to have_link(@changes.first.title, href: engineering_change_path(@changes.first))
    end
  end
end
