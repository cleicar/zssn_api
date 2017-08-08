require 'rails_helper'

RSpec.describe "Survivors", type: :request do
  describe "GET /survivors" do
    it "works! (now write some real specs)" do
      get survivors_path
      expect(response).to have_http_status(200)
    end
  end
end
