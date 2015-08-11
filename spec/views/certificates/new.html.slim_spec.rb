require 'rails_helper'

RSpec.describe "certificates/new.html.slim", type: :view do
  it 'renders the _form partial' do
    assign(:certificate, Certificate.new)
    render
    expect(response).to render_template(partial: '_form')
  end
end
