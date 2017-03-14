require 'rails_helper'

RSpec.describe "lists/_form", type: :view do

  include RSpecHtmlMatchers

  it 'has the approriate form elements' do
    assign(:list, build(:list))
    render partial: 'form'
    expect(rendered).to have_tag('form', with: {action: lists_path(@list), method: 'post'}) do
      with_tag 'input', with: { name: 'list[name]' }
      with_tag 'input', with: { name: 'list[description]' }
      with_text_area 'list[schema]'
    end
  end

end
