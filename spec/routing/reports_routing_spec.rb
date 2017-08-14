require "rails_helper"

RSpec.describe ReportsController, type: :routing do
  describe "routing" do

    it "routes to #infected_survivors" do
      expect(:get => "/reports/infected_survivors").to route_to("reports#infected_survivors")
    end

    it "routes to #not_infected_survivors" do
      expect(:get => "/reports/not_infected_survivors").to route_to("reports#not_infected_survivors")
    end

    it "routes to #resources_by_survivor" do
      expect(:get => "/reports/resources_by_survivor").to route_to("reports#resources_by_survivor")
    end
    
    it "routes to #lost_infected_points" do
      expect(:get => "/reports/lost_infected_points").to route_to("reports#lost_infected_points")
    end

  end
end
