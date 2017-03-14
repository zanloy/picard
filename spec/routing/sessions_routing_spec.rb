# frozen_string_literal: true
require "rails_helper"

RSpec.describe SessionsController, type: :routing do
  describe "routing" do

    it "routes to #create" do
      expect(post: "/sessions").to route_to("sessions#create")
    end

    it "routes to #destroy" do
      expect(delete: "/sessions/1").to route_to("sessions#destroy", id: "1")
    end

    it "signout routes to #destroy" do
      expect(get: "/signout").to route_to("sessions#destroy")
    end

    it 'signin routes to #login' do
      expect(get: '/signin').to route_to('sessions#login')
    end

    it 'oauth endpoint routes to #create' do
      expect(get: '/auth/oauth/callback').to route_to('sessions#create', provider: 'oauth')
    end

    it 'route to #disabled' do
      expect(get: '/disabled').to route_to('sessions#disabled')
    end
    
  end
end
