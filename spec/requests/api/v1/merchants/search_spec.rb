require 'rails_helper'

RSpec.describe "Api::V1::Merchants::Searches", type: :request do
    describe "GET /find " do
      let(:valid_attributes) {
      {name: Faker::Name.name}
    }

    let(:invalid_attributes) {
    {name: ''}
    }

    let(:valid_headers) {
      {"CONTENT_TYPE" => "application/json"}
      {"Etag" => "f22061f294b256cf0e04fa4d150cee30"}
      {"Cache-Control" => "max-age=0, private, must-revalidate"}
      {"X-Request-id" => "aab43c90-7f82-4ec7-9101-6a22b6e341e4"}
      {"X-Runtime" => "0.095101"}
      {"Transfer-Encoding" => "chunked"}
    }
    describe "get /find" do
      it 'happy path testing' do
        @merchant = Merchant.create(name: 'Findme now')
        get '/api/v1/merchants/find?name=iNdM', headers: valid_headers, as: :json
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data][:attributes][:name]).to eq('Findme now')
      end

      it 'edge case testing /find?name=' do
        merchants = Merchant.all
        get '/api/v1/merchants/find?name=', headers: valid_headers, as: :json
        expect(response).to have_http_status(400)
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].size).to eq(0)
      end

      it 'edge case testing /find' do
        merchants = Merchant.all
        get '/api/v1/merchants/find', headers: valid_headers, as: :json
        expect(response).to have_http_status(400)
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].size).to eq(0)
      end
    end

    describe "GET /find_all" do

      it 'happy path testing' do
        @merchant = Merchant.create(name: 'Findme now')
        @merchant = Merchant.create(name: 'Kindme later')
        @merchant = Merchant.create(name: 'Bindme now')
        get '/api/v1/merchants/find_all?name=iNdM', headers: valid_headers, as: :json
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].class).to eq(Array)
        expect(body[:data].size).to eq(3)
      end

      it "Get /find_all edge case" do
        get '/api/v1/merchants/find_all', headers: valid_headers, as: :json
        expect(response).to have_http_status(400)
      end

      it "Get /find_all edge case" do
        get '/api/v1/merchants/find_all', headers: valid_headers, as: :json
        expect(response).to have_http_status(400)
      end
    end
  end
end
