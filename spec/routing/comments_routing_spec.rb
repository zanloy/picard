# frozen_string_literal: true
require "rails_helper"

RSpec.describe CommentsController, type: :routing do
  describe "routing" do

    it "routes to #destroy" do
      expect(delete: "/comments/1").to route_to("comments#destroy", id: "1")
    end

  end
end
