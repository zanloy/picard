require 'rails_helper'

RSpec.describe "apps/new", type: :view do
  before(:each) do
    assign(:app, App.new())
  end

  it "renders new app form" do
    render

    assert_select "form[action=?][method=?]", apps_path, "post" do
    end
  end
end
