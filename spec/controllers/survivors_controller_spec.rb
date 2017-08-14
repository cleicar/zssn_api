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
      survivor = FactoryGirl.create(:survivor, resources_attributes: [water])
      
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

        resources = Resource.where(survivor_id: json_response[:_id]['$oid'])

        expect(resources).to_not be_nil
        expect(resources.first[:type]).to eq "Water"
        expect(resources.second[:type]).to  eq "Food"
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new survivor" do
        post :create, params: {survivor: survivor_params.except(:name)}

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq 'application/json'
      end

      it "should not allow survivor without declare resources" do 
        post :create, params: {survivor: invalid_attributes}

        expect(response).to have_http_status(:conflict)
        expect(response.body).to eq 'survivor need to declare its own resources'
      end
    end
  end

  describe "Updating survivor's location" do
    let(:update_params) do 
      {
        latitude: '-16.6868824', 
        longitude: '-49.2647885'
      }
    end

    it "A survivor must be able to update their last location" do
      survivor = FactoryGirl.create(:survivor, resources_attributes: [water, food])

      put :update, params: { id: survivor.to_param, survivor: update_params }

      expect(response).to have_http_status(:no_content)

      survivor.reload

      expect(survivor.last_location[:latitude]).to eq(update_params[:latitude])
      expect(survivor.last_location[:longitude]).to eq(update_params[:longitude])
    end

    it "should return error status if survivor does not exist" do 
      survivor = FactoryGirl.create(:survivor, resources_attributes: [water, food])

      put :update, params: { id: '999', survivor: update_params }

      expect(response).to have_http_status(:not_found)
    end
  end

  describe "Flag survivor as infected" do 
    context 'with a valid survivor' do
      let(:not_infected_survivor){
        FactoryGirl.create :survivor, :not_infected, resources_attributes: [water, food]
      }

      let(:almost_infected_survivor){
        FactoryGirl.create :survivor, :almost_infected, resources_attributes: [water, food]
      }        

      it "should increment the infection counter" do       
        post :flag_infection, params: { id: not_infected_survivor.to_param }

        expect(response.status).to eq 200

        expect(json_response[:message]).to eq "Attention! Survivor was reported as infected 1 time(s)!"

        not_infected_survivor.reload

        expect(not_infected_survivor.infected?).to eq false
        expect(not_infected_survivor.infection_count).to eq 1
      end

      it "if the infection count is 3 should return a infected warning" do 
        post :flag_infection, params: { id: almost_infected_survivor.to_param }

        expect(response.status).to eq 200

        expect(json_response[:message]).to eq "Warning! Infected survivor reported as infected 3 time(s)!"

        almost_infected_survivor.reload

        expect(almost_infected_survivor.infected?).to eq true
        expect(almost_infected_survivor.infection_count).to eq 3
      end      
    end

    context 'with a invalid survivor' do
      it 'should returns an not found error' do
        post :flag_infection, params: { id: 123 }
        expect(response.status).to eq(404)
      end
    end
  end

end
