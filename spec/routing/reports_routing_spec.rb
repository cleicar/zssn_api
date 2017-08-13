require "rails_helper"

RSpec.describe ReportsController, type: :routing do
  describe "routing" do

    it "routes to #infected_survivors" do
      expect(:get => "/reports/infected_survivors").to route_to("reports#infected_survivors")
    end

    it "routes to #not_infected_survivors" do
      expect(:get => "/reports/not_infected_survivors").to route_to("reports#not_infected_survivors")
    end

  end
end
