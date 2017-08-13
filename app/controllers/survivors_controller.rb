class SurvivorsController < ApplicationController
  before_action :set_survivor, only: [:update, :flag_infection]

  # GET /survivors
  def index
    @survivors = Survivor.all

    render json: @survivors, status: :ok
  end

  # POST /survivors
  def create
    if resources_params.has_key?(:resources)
      @survivor = Survivor.new(survivor_params.merge(resources_attributes: resources_params[:resources]))

      if @survivor.save
        render json: @survivor, status: :created, location: @survivor
      else
        render json: @survivor.errors, status: :unprocessable_entity
      end
    else
      render json: "survivor need to declare its own resources", status: :unprocessable_entity
    end       
  end

  # PATCH/PUT /survivors/:id
  def update
    if update_params.present?
      @survivor.update_attributes(last_location: {longitude: update_params[:longitude], latitude: update_params[:latitude]})
      head 204
    end
  end

  # POST /survivors/:id/flag_infection
  def flag_infection
    @survivor.inc(infection_count: 1)

    if @survivor.infected?
      render json: { message: "Warning! Infected survivor reported as infected #{@survivor.infection_count} time(s)!" }, status: :ok
    else
      render json: { message: "Attention! Survivor was reported as infected #{@survivor.infection_count} time(s)!" },status: :ok
    end
  end

  private
    def set_survivor
      @survivor = Survivor.find(params[:id])
      head 404 if @survivor.blank?
    end

    def survivor_params
      params.require(:survivor).permit(:name, :age, :gender, last_location: {})
    end

    def resources_params
      params.require(:survivor).permit(resources: [:type, :quantity])
    end

    def update_params
      params.require(:survivor).permit(:longitude, :latitude)
    end
end
