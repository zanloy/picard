require 'rails_helper'

RSpec.describe "two_words/index", type: :view do
  before(:each) do
    assign(:two_words, [
      TwoWord.create!(
        :name => "Name"
      ),
      TwoWord.create!(
        :name => "Name"
      )
    ])
  end

  it "renders a list of two_words" do
    render
    assert_select "tr>td", :text => "Name".to_s, :count => 2
  end
end
