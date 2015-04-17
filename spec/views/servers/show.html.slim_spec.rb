require 'rails_helper'

RSpec.describe "servers/show", type: :view do
  before(:each) do
    @server = assign(:server, Server.create!(
      :name => "Name",
      :environment_id => nil,
      :ip_address => "Ip Address",
      :ports => "Ports"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(//)
    expect(rendered).to match(/Ip Address/)
    expect(rendered).to match(/Ports/)
  end
end
