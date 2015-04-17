require 'rails_helper'

RSpec.describe "servers/index", type: :view do
  before(:each) do
    assign(:servers, [
      Server.create!(
        :name => "Name",
        :environment_id => nil,
        :ip_address => "Ip Address",
        :ports => "Ports"
      ),
      Server.create!(
        :name => "Name",
        :environment_id => nil,
        :ip_address => "Ip Address",
        :ports => "Ports"
      )
    ])
  end

  it "renders a list of servers" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Ip Address".to_s, :count => 2
    assert_select "tr>td", :text => "Ports".to_s, :count => 2
  end
end
