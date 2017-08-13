class ReportsController < ApplicationController
  before_action :check_survivors

  # GET /reports/infected_survivors
  def infected_survivors
    render json: { data: percentage_of(Survivor.infecteds.count, Survivor.count) }, status: :ok
  end

  # GET /reports/not_infected_survivors
  def not_infected_survivors
    render json: { data: percentage_of(Survivor.not_infecteds.count, Survivor.count) }, status: :ok
  end

  # GET /reports/resources_by_survivor
  def resources_by_survivor
    survivors_count = Survivor.count.to_f
    averages       = {}

    Resource::RESOURCES_TYPES.each do |resource_type|
      resource_amount = Resource.public_send(resource_type).sum(:quantity).to_f
      averages[resource_type] = resource_amount / survivors_count
    end

    render json: { averages: averages }, status: :ok
  end

  private
  def check_survivors
    unless Survivor.exists?
      render json: { error: 'There are no survivors' }, status: :conflict
    end
  end

  def percentage_of(value, total)
    (value.to_f / total.to_f * 100.0).round(2).to_s + "%"
  end
end
