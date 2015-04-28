require 'rails_helper'

RSpec.describe "engineering_changes/index", type: :view do
  before(:each) do
    assign(:current_user, User.first)
    environment = Environment.create!({name: 'Test Environment'})
    EngineeringChange.create!(
      entered_by_id: 1,
      poc_id: 2,
      when: Time.now,
      environment_id: environment.id,
      title: 'Log Item #1',
      description: 'Log Item #1 Description',
    )
    EngineeringChange.create!(
      entered_by_id: 2,
      poc_id: 1,
      when: Time.now,
      environment_id: environment.id,
      title: 'Log Item #2',
      description: 'Log Item #2 Description',
    )
    assign(:changes, EngineeringChange.timeline.page(1))
  end

  it "renders a list of changes" do
    render
    assert_select "tr>td", text: User.find(1).name, count: 1
    assert_select "tr>td", text: User.find(2).name, count: 1
    assert_select "tr>td", text: 'Test Environment', count: 2
    assert_select "tr>td", text: 'Log Item #1', count: 1
    assert_select "tr>td", text: 'Log Item #2', count: 1
  end
end
