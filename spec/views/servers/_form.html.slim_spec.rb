require 'rails_helper'

RSpec.describe 'servers/_form', type: :view do
  it 'renders a server form' do
    assign(:server, build(:server))
    render partial: 'form'
    assert_select 'form[action=?][method=?]', servers_path, 'post' do
      assert_select 'input#server_name[name=?]', 'server[name]'
      assert_select 'select#server_environment_id[name=?]', 'server[environment_id]'
      assert_select 'input#server_ip_address[name=?]', 'server[ip_address]'
      assert_select 'input#server_ports[name=?]', 'server[ports]'
    end
  end
end
