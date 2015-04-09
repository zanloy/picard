require 'rails_helper'

RSpec.describe "two_words/show", type: :view do
  before(:each) do
    @two_word = assign(:two_word, TwoWord.create!(
      :name => "Name"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
  end
end
