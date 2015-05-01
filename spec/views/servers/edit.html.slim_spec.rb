require 'rails_helper'

RSpec.describe 'servers/edit', type: :view do
  before(:each) do
    @environment = create(:environment)
    @server = assign(:server, build(:server, environment_id: @environment.id))
    render
  end

  it 'renders the _form partial' do
    expect(response).to render_template(partial: '_form')
  end

  it 'pre-populates the form' do
    assert_select 'input#server_name[name=?]', 'server[name]', value: @server.name
    assert_select 'select#server_environment_id[name=?]', 'server[environment_id]', value: @environment.name
    assert_select 'input#server_ip_address[name=?]', 'server[ip_address]', value: @server.ip_address
    assert_select 'input#server_ports[name=?]', 'server[ports]', value: @server.ports
  end

end
