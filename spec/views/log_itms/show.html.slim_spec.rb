require 'rails_helper'

RSpec.describe "log_itms/show", type: :view do
  before(:each) do
    @log_itm = assign(:log_itm, LogItm.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
