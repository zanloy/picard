require 'rails_helper'

RSpec.describe "environments/index.html.slim", type: :view do
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
    @environments = create_pair(:environment)
    @environments.each do |environment|
      create(:server, environment: environment)
      create_pair(:engineering_change, environment: environment)
    end
    assign(:environments, @environments)
    render
  end

  it 'displays all the environments' do
    @environments.each do |environment|
      assert_select 'tr>td', text: environment.name
    end
  end

  it 'shows how many servers are associated with each environment' do
    assert_select 'tr>td', text: '1', count: 2
  end

  it 'shows how many changes are associated with each environment' do
    assert_select 'tr>td', text: '2', count: 2
  end

end
