# frozen_string_literal: true
require "rails_helper"

RSpec.describe SubscriptionsController, type: :routing do
  describe "routing" do

    it "routes to #destroy" do
      expect(delete: "/subscriptions/1").to route_to("subscriptions#destroy", id: "1")
    end

  end
end
