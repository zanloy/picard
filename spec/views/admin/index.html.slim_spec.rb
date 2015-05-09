require 'rails_helper'

RSpec.describe "admin/index.html.slim", type: :view do

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
    @enabled_users = create_pair(:user)
    @disabled_users = create_pair(:user, :disabled)
    assign(:enabled_users, @enabled_users)
    assign(:disabled_users, @disabled_users)
    render
  end

  it 'displays enabled users' do
    @enabled_users.each do |user|
      assert_select 'tr', id: "user_#{user.id}"
    end
  end

  it 'displays disabled users' do
    @disabled_users.each do |user|
      assert_select 'tr', id: "user_#{user.id}"
    end
  end

end
