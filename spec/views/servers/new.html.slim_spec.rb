require 'rails_helper'

RSpec.describe "servers/new", type: :view do
  before(:each) do
    assign(:server, Server.new(
      :name => "MyString",
      :environment_id => nil,
      :ip_address => "MyString",
      :ports => "MyString"
    ))
  end

  it "renders new server form" do
    render

    assert_select "form[action=?][method=?]", servers_path, "post" do

      assert_select "input#server_name[name=?]", "server[name]"

      assert_select "input#server_environment_id_id[name=?]", "server[environment_id_id]"

      assert_select "input#server_ip_address[name=?]", "server[ip_address]"

      assert_select "input#server_ports[name=?]", "server[ports]"
    end
  end
end
