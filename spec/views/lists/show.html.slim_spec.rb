require 'rails_helper'

RSpec.describe "lists/show", type: :view do

  include RSpecHtmlMatchers

  before(:each) do
    @list = assign(:list, create(:list))
    @alerts = assign(:alerts, build_pair(:alert, list: @list))
    @list_items = assign(:list_items, build_pair(:list_item, list: @list))
    render
  end

  it 'renders the list details' do
    expect(rendered).to match @list.name
    expect(rendered).to match simple_format(@list.description)
  end

  it 'renders the associated alerts' do
    @alerts.each do |alert|
      expect(rendered).to match CGI::escapeHTML(alert.to_s)
    end
  end

  it 'renders the table headers' do
    @list.fields.each do |field|
      expect(rendered).to match(field)
    end
  end

  it 'renders the list items' do
    @list_items.each do |item|
      item.fields.each do |field|
        expect(rendered).to match item.get_field(field)
      end
    end
  end

end
