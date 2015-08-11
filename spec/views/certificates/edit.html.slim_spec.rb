require 'rails_helper'

RSpec.describe "certificates/edit.html.slim", type: :view do

  before(:each) do
    @certificate = assign(:certificate, create(:certificate))
    render
  end

  it 'renders the _form partial' do
    expect(response).to render_template(partial: '_form')
  end
end
