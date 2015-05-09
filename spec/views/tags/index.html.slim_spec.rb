require 'rails_helper'

RSpec.describe "tags/index.html.slim", type: :view do
  before(:each) do
    @tags = create_pair(:tag)
    assign(:tags, @tags)
    render
  end

  it 'shows the tag cloud' do
    assert_select 'div', id: :tag_cloud
  end
  
  it 'shows all the tags as links' do
    @tags.each do |tag|
      assert_select 'a', text: tag.name, href: tag_path(tag)
    end
  end
end
