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
    @enabled_users = assign(:enabled_users, create_pair(:user))
    @disabled_users = assign(:disabled_users, create_pair(:user, :disabled))
    @banned_users = assign(:banned_users, create_pair(:user, :banned))
    render
  end

  it 'displays enabled users' do
    @enabled_users.each do |user|
      assert_select 'tr', id: "user_#{user.id}" do
        assert_select 'td', user.name
        assert_select 'td', user.email
      end
    end
  end

  it 'displays disabled users' do
    @disabled_users.each do |user|
      assert_select 'tr', id: "user_#{user.id}" do
        assert_select 'td', user.name
        assert_select 'td', user.email
      end
    end
  end

  it 'displays banned users' do
    @banned_users.each do |user|
      assert_select 'tr', id: "user_#{user.id}" do
        assert_select 'td', user.name
        assert_select 'td', user.email
      end
    end
  end
end
