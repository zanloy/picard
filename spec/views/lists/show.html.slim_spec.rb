require 'rails_helper'

RSpec.describe "lists/show", type: :view do
  before(:each) do
    @list = assign(:list, build(:list))
  end

  it 'renders the list details'
  it 'renders the list items'
end
