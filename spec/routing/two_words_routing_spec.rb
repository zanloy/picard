require "rails_helper"

RSpec.describe TwoWordsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/two_words").to route_to("two_words#index")
    end

    it "routes to #new" do
      expect(:get => "/two_words/new").to route_to("two_words#new")
    end

    it "routes to #show" do
      expect(:get => "/two_words/1").to route_to("two_words#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/two_words/1/edit").to route_to("two_words#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/two_words").to route_to("two_words#create")
    end

    it "routes to #update" do
      expect(:put => "/two_words/1").to route_to("two_words#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/two_words/1").to route_to("two_words#destroy", :id => "1")
    end

  end
end
