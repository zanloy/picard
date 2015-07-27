require 'rails_helper'

RSpec.describe "lists/edit", type: :view do

  include RSpecHtmlMatchers

  before(:each) do
    @list = assign(:list, create(:list))
    render
  end

  it 'renders the _form partial' do
    expect(rendered).to render_template(partial: '_form')
  end

  it 'pre-populates the form' do
    expect(rendered).to have_tag('form', with: {action: list_path(@list), method: 'post'}) do
      with_tag 'input', with: { name: 'list[name]', value: @list.name }
      with_tag 'input', with: { name: 'list[description]', value: @list.description }
      with_tag 'textarea', with: { name: 'list[schema]' } do
        # I have to preceed the match with a newline because simple_form inserts
        # a newline for no reason.
        with_text "\n#{@list.schema}"
      end
    end
  end

end
