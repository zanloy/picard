require 'rails_helper'

RSpec.describe 'engineering_changes/new.html.slim', type: :view do
  it 'renders the _form partial' do
    assign(:change, EngineeringChange.new)
    render
    expect(response).to render_template(partial: '_form')
  end
end
