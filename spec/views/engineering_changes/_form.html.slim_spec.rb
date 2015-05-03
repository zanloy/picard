require 'rails_helper'

RSpec.describe 'engineering_changes/_form', type: :view do
  it 'renders a change form' do
    assign(:change, build(:engineering_change))
    render partial: 'form'
    assert_select 'form[action=?][method=?]', engineering_changes_path, 'post' do
      assert_select 'select#engineering_change_poc_id[name=?]', 'engineering_change[poc_id]'
      assert_select 'input#engineering_change_when[name=?]', 'engineering_change[when]'
      assert_select 'select#engineering_change_environment_id[name=?]', 'engineering_change[environment_id]'
      assert_select 'input#engineering_change_title[name=?]', 'engineering_change[title]'
      assert_select 'textarea#engineering_change_description[name=?]', 'engineering_change[description]'
    end
  end
end
