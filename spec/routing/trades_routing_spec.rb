require "rails_helper"

RSpec.describe TradesController, type: :routing do
  describe "routing" do

    it "routes to #trade_resources" do
      expect(:post => "/trade_resources").to route_to("trades#trade_resources")
    end

  end
end
