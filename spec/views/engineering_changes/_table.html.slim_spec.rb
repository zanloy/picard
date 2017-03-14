# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'engineering_changes/_table', type: :view do

  before(:each) {
    @current_user = create(:user)
    assign(:current_user, @current_user)
    @environment = create(:environment)
    @changes = create_pair(:engineering_change, poc_id: @current_user.id, environment_id: @environment.id)
    render partial: 'table', object: @changes
  }

  describe 'renders the records' do
    it 'with the environment name' do
      @changes.each do |change|
        expect(rendered).to have_content(change.environment.name)
      end
    end

    it 'with the change title' do
      @changes.each do |change|
        expect(rendered).to have_content(change.title)
      end
    end

    it 'with the POC name' do
      @changes.each do |change|
        expect(rendered).to have_content(change.poc.name)
      end
    end

    it 'with a link to the change' do
      @changes.each do |change|
        expect(rendered).to have_link(nil, href: engineering_change_path(change))
      end
    end
  end # describe 'renders the records'
end
