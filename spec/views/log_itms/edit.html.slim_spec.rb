require 'rails_helper'

RSpec.describe "log_itms/edit", type: :view do
  before(:each) do
    @log_itm = assign(:log_itm, LogItm.create!())
  end

  it "renders the edit log_itm form" do
    render

    assert_select "form[action=?][method=?]", log_itm_path(@log_itm), "post" do
    end
  end
end
