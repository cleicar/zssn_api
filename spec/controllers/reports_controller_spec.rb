require 'rails_helper'

RSpec.describe ReportsController, type: :controller do

  describe "GET #infected_survivors" do
    context 'with valid survivors' do
      before do 
        FactoryGirl.create_list(:survivor, 50, :not_infected, :with_resources)
        FactoryGirl.create_list(:survivor, 15, :infected, :with_resources)
      end

      it "should return the infected survivors percentage" do
        get :infected_survivors
        expect(response).to have_http_status(:ok)
        expect(json_response[:data]).to eq '23.08%'
      end
    end

    context 'with invalid survivors' do
      it "should return erro if there is no survivors" do 
        get :infected_survivors
        expect(response).to have_http_status(:conflict)
        expect(json_response[:error]).to eq 'There are no survivors'
      end
    end
  end

  describe "GET #not_infected_survivors" do
    context 'with valid survivors' do
      before do 
        FactoryGirl.create_list(:survivor, 50, :not_infected, :with_resources)
        FactoryGirl.create_list(:survivor, 15, :infected, :with_resources)
      end

      it "should return the not infected survivors percentage" do
        get :not_infected_survivors
        expect(response).to have_http_status(:ok)
        expect(json_response[:data]).to eq '76.92%'
      end
    end

    context 'with invalid survivors' do
      it "should return erro if there is no survivors" do 
        get :not_infected_survivors
        expect(response).to have_http_status(:conflict)
        expect(json_response[:error]).to eq 'There are no survivors'
      end
    end
  end

end
