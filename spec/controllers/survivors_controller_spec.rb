require 'rails_helper'

RSpec.describe SurvivorsController, type: :controller do

  let(:survivor_params) {
    FactoryGirl.attributes_for :survivor,
    resources: [water, food]
  }

  let(:invalid_attributes) {
    FactoryGirl.attributes_for :survivor
  }

  let(:water){
    FactoryGirl.attributes_for :resource, :water
  }

  let(:food){
    FactoryGirl.attributes_for :resource, :food
  }

  describe "Listing survivors" do
    it "should returns all survivors" do
      survivor = Survivor.create! survivor_params
      
      get :index

      json_response = JSON.parse(response.body)

      expect(response).to be_success
      expect(response.status).to eq(200)
      expect(json_response.count).to eq 1
    end
  end

  describe "Adding a survivor" do
    context "with valid params" do
      it "should create a new Survivor" do
        expect {
          post :create, params: {survivor: survivor_params}
        }.to change(Survivor, :count).by(1)
      end

      it "should render a JSON response with the new survivor" do
        post :create, params: {survivor: survivor_params}

        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(survivor_url(Survivor.last))
      end

      it "should save all survivor's attributes" do 
        post :create, params: {survivor: survivor_params}

        created_survivor = Survivor.last

        expect(created_survivor.attributes.except("_id", "resources")).to eq survivor_params.except(:resources).with_indifferent_access
      end

      it "should save survivor's resources" do
        post :create, params: {survivor: survivor_params}

        expect(json_response[:resources]).to_not be_nil
        expect(json_response[:resources].size).to eq 2
        expect(json_response[:resources].first[:type]).to eq "Water"
        expect(json_response[:resources].second[:type]).to eq "Food"
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new survivor" do
        post :create, params: {survivor: invalid_attributes}        

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq 'application/json'
      end

      it "should not allow survivor without declare resources" do 
        post :create, params: {survivor: invalid_attributes}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to eq 'survivor need to declare its own resources'
      end
    end
  end
end
