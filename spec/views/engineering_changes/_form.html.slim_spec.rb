require 'rails_helper'

RSpec.describe 'engineering_changes/_form', type: :view do

  include RSpecHtmlMatchers

  it 'renders a change form' do
    @change = assign(:change, build(:engineering_change))
    assign(:environments, create_pair(:environment))
    render partial: 'form'
    expect(rendered).to have_tag('form', with: {action: engineering_changes_path(@change), method: 'post'}) do
      with_select 'engineering_change[poc_id]'
      with_text_field 'engineering_change[when]'
      with_select 'engineering_change[environment_id]'
      with_text_field 'engineering_change[title]'
      with_text_area 'engineering_change[description]'
    end
  end

end
