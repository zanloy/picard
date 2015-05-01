require 'rails_helper'

RSpec.describe 'environments/edit.html.slim', type: :view do
  before(:each) do
    @environment = assign(:environment, build(:environment))
    render
  end

  it 'renders the _form partial' do
    expect(response).to render_template('_form')
  end

  it 'pre-populates the form' do
    assert_select "form[action=?][method=?]", environments_path, "post" do
      assert_select "input#environment_name[name=?]", "environment[name]", value: @environment.name
      assert_select "input#environment_domain[name=?]", "environment[domain]", value: @environment.domain
    end
  end
end
