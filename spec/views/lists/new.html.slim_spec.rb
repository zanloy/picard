require 'rails_helper'

RSpec.describe "lists/new", type: :view do
  
    include RSpecHtmlMatchers

    before(:each) do
      @list = assign(:list, List.new)
      render
    end

    it 'renders the _form partial' do
      expect(rendered).to render_template(partial: '_form')
    end

end
