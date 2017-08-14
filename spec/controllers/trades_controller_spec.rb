require 'rails_helper'

RSpec.describe TradesController, type: :controller do

  let(:survivor_1) {
    FactoryGirl.create :survivor_1,
    resources_attributes: [
      FactoryGirl.attributes_for(:resource, :water, quantity: 6),
      FactoryGirl.attributes_for(:resource, :medication, quantity: 3),
    ]
  }

  let(:survivor_2) {
    FactoryGirl.create :survivor_2,
    resources_attributes: [
      FactoryGirl.attributes_for(:resource, :medication, quantity: 7),
      FactoryGirl.attributes_for(:resource, :ammunition, quantity: 10),
    ]
  }

  describe "Trade resources between two survivors" do
    let(:resources_to_trade_survivor_1) {
      [ {type: 'Water', quantity: 1}, {type: 'Medication', quantity: 1} ]
    }

    let(:resources_to_trade_survivor_2) {
      [ {type: 'Ammunition', quantity: 6} ]
    }

    let(:trade_params) do
      {
        trade: {
          survivor_1: {
            id: survivor_1.to_param,
            resources: resources_to_trade_survivor_1
          },
          survivor_2: {
            id: survivor_2.to_param,
            resources: resources_to_trade_survivor_2
          }
        }
      }
    end

    it 'should raise error when a survivor does not exist' do 
      trade_params[:trade][:survivor_1][:id] = '999'

      post :trade_resources, params: trade_params

      expect(response).to have_http_status(:conflict)
      expect(json_response['error']).to eq('Survivor with id 999 does not exist')
    end

    it 'should not allow trade when a survivor is infected' do
      survivor_2.update_attribute(:infection_count, 4)

      post :trade_resources, params: trade_params

      expect(response).to have_http_status(:conflict)
      expect(json_response['error']).to eq('Mary Adams is infected')
    end

    it 'should not allow trade when a survivor has not enough resources' do 
      survivor_2.resources.find_by(type: 'Ammunition').update(quantity: 2)

      post :trade_resources, params: trade_params, as: :json

      expect(response).to have_http_status(:conflict)
      expect(json_response['error']).to eq("#{survivor_2.name} doesn't have enough resources")

      survivor_1.reload

      expect(survivor_1.resources.find_by(type: 'Water').quantity).to eq 6
      expect(survivor_1.resources.find_by(type: 'Medication').quantity).to eq 3
    end

    it 'should not allow trade when the resources is not balanced' do 
      trade_params[:trade][:survivor_1][:resources][0][:quantity] = 6

      post :trade_resources, params: trade_params, as: :json

      expect(response).to have_http_status(:conflict)
      expect(json_response['error']).to eq('Resources points is not balanced both sides')

      survivor_1.reload

      expect(survivor_1.resources.find_by(type: 'Water').quantity).to eq 6
      expect(survivor_1.resources.find_by(type: 'Medication').quantity).to eq 3
    end
  end

end
