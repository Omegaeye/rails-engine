require 'rails_helper'

RSpec.describe "Api::V1::Merchants", type: :request do
  describe "GET /index" do
    before :each do
      create_list(:merchant, 20)
      get '/api/v1/merchants'
    end

    it "Response status 200 and ok" do
      expect(response).to have_http_status(:ok)
      expect(response.status).to eq(200)
    end

    it "JSON body response contains expected attributes" do
      body = JSON.parse(response.body)
      expect(body.class).to eq(Hash)
      expect(body["data"].class).to eq(Array)
      expect(body["data"]).to match_array(body["data"])
    end

  end
end
