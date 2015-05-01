require 'rails_helper'

RSpec.describe 'servers/new', type: :view do
  it 'renders the _form partial' do
    assign(:server, Server.new)
    render
    expect(response).to render_template(partial: '_form')
  end
end
