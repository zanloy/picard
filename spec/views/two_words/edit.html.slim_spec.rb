require 'rails_helper'

RSpec.describe "two_words/edit", type: :view do
  before(:each) do
    @two_word = assign(:two_word, TwoWord.create!(
      :name => "MyString"
    ))
  end

  it "renders the edit two_word form" do
    render

    assert_select "form[action=?][method=?]", two_word_path(@two_word), "post" do

      assert_select "input#two_word_name[name=?]", "two_word[name]"
    end
  end
end
