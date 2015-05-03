require 'rails_helper'

RSpec.describe 'engineering_changes/index', type: :view do
  before do
    controller.singleton_class.class_eval do
      protected
      def is_admin?
        true
      end
      def will_paginate(items)
        nil
      end
      helper_method :is_admin?, :will_paginate
    end
  end

  before(:each) do
    assign(:current_user, create(:user))
    assign(:changes, create_pair(:engineering_change))
    render
  end

  it 'has a quick add form' do
    assert_select 'form[action=?][method=?]', engineering_changes_path, 'post' do
      assert_select 'input#engineering_change_quick_add[name=?]', 'engineering_change[quick_add]'
      assert_select 'select#engineering_change_environment_id[name=?]', 'engineering_change[environment_id]'
      assert_select 'input#engineering_change_title[name=?]', 'engineering_change[title]'
    end
  end

  it 'renders the _table template' do
    expect(rendered).to render_template(partial: '_table')
  end

end
