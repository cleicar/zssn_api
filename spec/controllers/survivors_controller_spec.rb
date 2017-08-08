require 'rails_helper'

RSpec.describe SurvivorsController, type: :controller do

  let(:survivor_params) {
    {
      "name"=>"Survivor Test", 
      "age" => '43',
      "gender" => 'M',
      "last_location" => {"latitude": '89809809809', "longitude": '-88983982100'}
    }
  }

  let(:invalid_attributes) {
    {
      "name"=>"Survivor Test"
    }
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

        created_survivor.attributes.delete("_id")

        expect(created_survivor.attributes).to eq survivor_params.with_indifferent_access
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new survivor" do
        post :create, params: {survivor: invalid_attributes}
        
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end
end
