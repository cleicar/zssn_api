class SurvivorsController < ApplicationController
  before_action :set_survivor, only: [:update]

  # GET /survivors
  def index
    @survivors = Survivor.all

    render json: @survivors, status: :ok
  end

  # POST /survivors
  def create
    @survivor = Survivor.new(survivor_params)

    unless resources_params.has_key?(:resources)
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

  # PATCH/PUT /books/1
  # PATCH/PUT /books/1.json
  def update
    if update_params.present?
      @survivor.update(new_location: update_params)
      json_response(@survivor)
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

    def update_params
      params.require(:survivor).permit(new_location: {})
    end
end
