# frozen_string_literal: true
require "rails_helper"

RSpec.describe EngineeringChangesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(get: "/changes").to route_to("engineering_changes#index")
    end

    it "routes to #create" do
      expect(post: "/changes").to route_to("engineering_changes#create")
    end

    it "routes to #new" do
      expect(get: "/changes/new").to route_to("engineering_changes#new")
    end

    it "routes to #edit" do
      expect(get: "/changes/1/edit").to route_to("engineering_changes#edit", id: "1")
    end

    it "routes to #show" do
      expect(get: "/changes/1").to route_to("engineering_changes#show", id: "1")
    end

    it "routes to #update" do
      expect(put: "/changes/1").to route_to("engineering_changes#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/changes/1").to route_to("engineering_changes#destroy", id: "1")
    end

  end

  describe "nested comments" do

    it "routes to comments#create" do
      expect(post: "/changes/1/c").to route_to("comments#create", engineering_change_id: "1")
    end

  end

  describe "nested subscription" do

    it "routes to subscriptions#create" do
      expect(post: "/changes/1/subscribe").to route_to("subscriptions#create", engineering_change_id: "1")
    end

  end

end
