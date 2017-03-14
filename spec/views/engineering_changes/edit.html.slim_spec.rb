require 'rails_helper'

RSpec.describe 'engineering_changes/edit.html.slim', type: :view do
  before(:each) do
    @poc = create(:user)
    @environment = create(:environment)
    @change = assign(:change, build(:engineering_change, poc_id: @poc.id, environment_id: @environment.id))
    assign(:environments, [@environment])
    render
  end

  it 'pre-populates the form' do
    assert_select 'form[action=?][method=?]', engineering_changes_path, 'post' do
      assert_select 'select#engineering_change_poc_id[name=?]', 'engineering_change[poc_id]', value: @poc.name
      assert_select 'input#engineering_change_when[name=?]', 'engineering_change[when]', value: @change.when
      assert_select 'select#engineering_change_environment_id[name=?]', 'engineering_change[environment_id]', value: @environment.name
      assert_select 'input#engineering_change_title[name=?]', 'engineering_change[title]', value: @change.title
      assert_select 'textarea#engineering_change_description[name=?]', 'engineering_change[description]', value: @change.description
    end
  end

end
