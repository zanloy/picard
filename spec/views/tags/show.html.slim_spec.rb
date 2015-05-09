require 'rails_helper'

RSpec.describe "tags/show.html.slim", type: :view do
  before(:each) do
    @tag = create(:tag)
    @changes = create_pair(:engineering_change)
    @changes.each { |change| change.tags = [@tag] }
    @taggables = { changes: @changes }
    assign(:current_user, create(:user))
    assign(:tag, @tag)
    assign(:taggables, @taggables)
    render
  end

  it 'shows changes related to the assigned tag' do
    @changes.each do |change|
      assert_select 'tr', id: "item_#{change.id}"
    end
  end
end
