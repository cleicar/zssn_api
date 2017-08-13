class TradesController < ApplicationController

  # POST /trade_resources
  def trade_resources   
    trade = Trade.new(trade_params)

    if trade.process
      render json: { message: trade.message }, status: :ok
    else
      render json: { error: trade.message }, status: :conflict
    end
  end

  private
    def trade_params
      params.require(:trade).permit(survivor_1: [:id, resources: [[:type, :quantity]]],
                                    survivor_2: [:id, resources: [[:type, :quantity]]])
    end
end
