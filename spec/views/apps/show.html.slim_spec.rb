require 'rails_helper'

RSpec.describe "apps/show", type: :view do
  before(:each) do
    @app = assign(:app, App.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
