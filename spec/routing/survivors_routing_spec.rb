require "rails_helper"

RSpec.describe SurvivorsController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/survivors").to route_to("survivors#index")
    end

    it "routes to #create" do
      expect(:post => "/survivors").to route_to("survivors#create")
    end
  end
end
