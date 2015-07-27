require 'rails_helper'

RSpec.describe "lists/index", type: :view do

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
    assign(:lists, create_pair(:list))
  end

  it "renders a list of lists" do
    render
  end
end
