require 'rails_helper'

RSpec.describe "two_words/new", type: :view do
  before(:each) do
    assign(:two_word, TwoWord.new(
      :name => "MyString"
    ))
  end

  it "renders new two_word form" do
    render

    assert_select "form[action=?][method=?]", two_words_path, "post" do

      assert_select "input#two_word_name[name=?]", "two_word[name]"
    end
  end
end
