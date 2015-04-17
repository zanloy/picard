require 'rails_helper'

RSpec.describe "servers/edit", type: :view do
  before(:each) do
    @server = assign(:server, Server.create!(
      :name => "MyString",
      :environment_id => nil,
      :ip_address => "MyString",
      :ports => "MyString"
    ))
  end

  it "renders the edit server form" do
    render

    assert_select "form[action=?][method=?]", server_path(@server), "post" do

      assert_select "input#server_name[name=?]", "server[name]"

      assert_select "input#server_environment_id_id[name=?]", "server[environment_id_id]"

      assert_select "input#server_ip_address[name=?]", "server[ip_address]"

      assert_select "input#server_ports[name=?]", "server[ports]"
    end
  end
end
