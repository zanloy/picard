require 'rails_helper'

RSpec.describe 'servers/_table', type: :view do
  it 'renders a list of servers' do
    environment = create(:environment)
    servers = assign(:server, create_pair(:server, environment_id: environment.id))
    render partial: 'table', object: servers
    servers.each do |server|
      assert_select "tr#server_#{server.id}" do
        assert_select 'td', text: server.name
        assert_select 'td', text: environment.name
        assert_select 'td', text: server.ip_address
        assert_select 'td', text: server.ports
      end
    end
  end
end
