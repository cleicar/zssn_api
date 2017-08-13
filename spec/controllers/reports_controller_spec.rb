require 'rails_helper'

RSpec.describe ReportsController, type: :controller do

  let(:water){ FactoryGirl.attributes_for :resource, :water }
  let(:food) { FactoryGirl.attributes_for :resource, :food }
  let(:medication){ FactoryGirl.attributes_for :resource, :medication }
  let(:ammunition){ FactoryGirl.attributes_for :resource, :ammunition }

  before do
    create_list(:survivor,  5, :infected, 
      resources_attributes: [
        attributes_for(:resource, :water, quantity: 3),
        attributes_for(:resource, :food,  quantity: 7),
        attributes_for(:resource, :medication, quantity: 1),
        attributes_for(:resource, :ammunition, quantity: 6),
      ]
      )

    create_list(:survivor, 15, :not_infected,
      resources_attributes: [
        attributes_for(:resource, :water, quantity: 2),
        attributes_for(:resource, :food,  quantity: 3),
        attributes_for(:resource, :medication, quantity: 8),
        attributes_for(:resource, :ammunition, quantity: 5),
      ]
      )
  end

  describe "GET #infected_survivors" do
    context 'with valid survivors' do
      it "should return the infected survivors percentage" do
        get :infected_survivors

        expect(response).to have_http_status(:ok)
        expect(json_response[:data]).to eq '25.0%'
      end
    end

    context 'with invalid survivors' do
      it "should return erro if there is no survivors" do 
        Survivor.delete_all

        get :infected_survivors

        expect(response).to have_http_status(:conflict)
        expect(json_response[:error]).to eq 'There are no survivors'
      end
    end
  end

  describe "GET #not_infected_survivors" do
    context 'with valid survivors' do
      it "should return the not infected survivors percentage" do
        get :not_infected_survivors
        expect(response).to have_http_status(:ok)
        expect(json_response[:data]).to eq '75.0%'
      end
    end

    context 'with invalid survivors' do
      it "should return erro if there is no survivors" do 
        Survivor.delete_all

        get :not_infected_survivors

        expect(response).to have_http_status(:conflict)
        expect(json_response[:error]).to eq 'There are no survivors'
      end
    end
  end

  describe "GET #resources_by_survivor" do
    context 'with valid survivors' do
      it "should return the not infected survivors percentage" do
        get :resources_by_survivor
        
        expect(response).to have_http_status(:ok)        
        expect(json_response[:averages][:water]).to eq 2.25
        expect(json_response[:averages][:food]).to eq 4.0
        expect(json_response[:averages][:medication]).to eq 6.25
        expect(json_response[:averages][:ammunition]).to eq 5.25
      end
    end
  end
end
