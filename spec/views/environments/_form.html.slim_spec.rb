require 'rails_helper'

RSpec.describe '/environments/_form', type: :view do
  it 'renders an environment form' do
    assign(:environment, Environment.new)
    render partial: 'form'

    assert_select "form[action=?][method=?]", environments_path, "post" do
      assert_select "input#environment_name[name=?]", "environment[name]"
      assert_select "input#environment_domain[name=?]", "environment[domain]"
    end
  end
end
