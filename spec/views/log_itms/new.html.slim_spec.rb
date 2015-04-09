require 'rails_helper'

RSpec.describe "log_itms/new", type: :view do
  before(:each) do
    assign(:log_itm, LogItm.new())
  end

  it "renders new log_itm form" do
    render

    assert_select "form[action=?][method=?]", log_itms_path, "post" do
    end
  end
end
