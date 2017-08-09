class SurvivorsController < ApplicationController
  before_action :set_survivor, only: [:show, :update, :destroy]

  # GET /survivors
  def index
    @survivors = Survivor.all

    render json: @survivors, status: :ok
  end

  # POST /survivors
  def create
    @survivor = Survivor.new(survivor_params)

    if resources_params[:resources].blank?
      render json: "survivor need to declare its own resources", status: :unprocessable_entity
    else
      
      resources_params[:resources].each do |resource|
        @survivor.build_resource(resource)
      end

      if @survivor.save
        render json: @survivor, status: :created, location: @survivor
      else
        render json: @survivor.errors, status: :unprocessable_entity
      end
    end       
  end

  private
    def set_survivor
      @survivor = Survivor.find(params[:id])
    end

    def survivor_params
      params.require(:survivor).permit(:name, :age, :gender, last_location: {})
    end

    def resources_params
      params.require(:survivor).permit(resources: [:type, :quantity])
    end
end
