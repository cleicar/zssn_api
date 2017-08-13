class ReportsController < ApplicationController

  # GET /infected_survivors
  def infected_survivors
    if Survivor.exists?
      render json: { data: percentage_of(Survivor.infecteds.count, Survivor.count) }, status: :ok
    else
      render json: { error: 'There are no survivors' }, status: :conflict
    end
  end

  private
  def percentage_of(value, total)
    (value.to_f / total.to_f * 100.0).round(2).to_s + "%"
  end
end
