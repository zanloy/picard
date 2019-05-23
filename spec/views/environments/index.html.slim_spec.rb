# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "environments/index.html.slim", type: :view do
  before do
    controller.singleton_class.class_eval do
      protected
      def admin?
        true
      end
      def will_paginate(items)
        nil
      end
      helper_method :admin?, :will_paginate
    end
  end

  before(:each) do
    @environments = create_pair(:environment)
    @environments.each do |environment|
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

end
