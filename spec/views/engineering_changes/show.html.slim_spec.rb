require 'rails_helper'

RSpec.describe 'engineering_changes/show.html.slim', type: :view do
  before do
    @user = create(:user)
    controller.singleton_class.class_eval do
      protected
      def current_user
        @user
      end
      def is_admin?
        true
      end
      helper_method :is_admin?
    end
  end

  before(:each) do
    assign(:current_user, @user)
    @poc = create(:user)
    @environment = create(:environment)
    @change = assign(:change, create(:engineering_change, poc_id: @poc.id, environment_id: @environment.id))
    @comments = create_pair(:comment, commentable_type: 'EngineeringChange', commentable_id: @change.id, user_id: @poc.id)
    render
  end

  it 'renders attributes' do
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/POC/)
    expect(rendered).to match(/Date/)
    expect(rendered).to match(/Environment/)
    expect(rendered).to match(/Description/)
  end

  it 'renders values' do
    expect(rendered).to have_content(@change.title)
    expect(rendered).to have_content(@poc.name)
    expect(rendered).to have_content(@change.when.strftime('%A, %m/%d/%Y'))
    expect(rendered).to have_content(@environment.name)
    expect(rendered).to have_content(@change.description)
  end

  it 'render comments' do
    @comments.each do |comment|
      expect(rendered).to have_content(comment.comment)
    end
  end
end
