require 'rails_helper'

RSpec.describe "engineering_changes/_table", type: :view do

  before(:each) {
    @current_user = User.first
    assign(:current_user, @current_user)
    @environment = Environment.create!({name: 'Test Environment'})
    @changes = [
      EngineeringChange.create!(
        entered_by_id: @current_user.id,
        poc_id: @current_user.id,
        when: Time.now,
        environment_id: @environment.id,
        title: 'Log Item #1',
        description: 'Log Item #1 Description',
      ),
      EngineeringChange.create!(
        entered_by_id: @current_user.id,
        poc_id: @current_user.id,
        when: Time.now,
        environment_id: @environment.id,
        title: 'Log Item #2',
        description: 'Log Item #2 Description',
      ),
    ]
    assign(:changes, @changes)
    render partial: 'table'
  }

  describe 'rendering changes' do

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
