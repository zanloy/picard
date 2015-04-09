require 'rails_helper'

RSpec.describe "apps/index", type: :view do
  before(:each) do
    assign(:apps, [
      App.create!(),
      App.create!()
    ])
  end

  it "renders a list of apps" do
    render
  end
end
