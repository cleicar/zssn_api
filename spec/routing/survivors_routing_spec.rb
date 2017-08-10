require "rails_helper"

RSpec.describe SurvivorsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/survivors").to route_to("survivors#index")
    end

    it "routes to #create" do
      expect(:post => "/survivors").to route_to("survivors#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/survivors/1").to route_to("survivors#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/survivors/1").to route_to("survivors#update", :id => "1")
    end

    it "routes to #flag_infection via POST" do
      expect(:post => "/survivors/1/flag_infection").to route_to("survivors#flag_infection", :id => "1")
    end    
  end
end
