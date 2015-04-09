require "rails_helper"

RSpec.describe LogItmsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/log_itms").to route_to("log_itms#index")
    end

    it "routes to #new" do
      expect(:get => "/log_itms/new").to route_to("log_itms#new")
    end

    it "routes to #show" do
      expect(:get => "/log_itms/1").to route_to("log_itms#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/log_itms/1/edit").to route_to("log_itms#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/log_itms").to route_to("log_itms#create")
    end

    it "routes to #update" do
      expect(:put => "/log_itms/1").to route_to("log_itms#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/log_itms/1").to route_to("log_itms#destroy", :id => "1")
    end

  end
end
