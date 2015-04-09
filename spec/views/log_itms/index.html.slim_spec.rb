require 'rails_helper'

RSpec.describe "log_itms/index", type: :view do
  before(:each) do
    assign(:log_itms, [
      LogItm.create!(),
      LogItm.create!()
    ])
  end

  it "renders a list of log_itms" do
    render
  end
end
