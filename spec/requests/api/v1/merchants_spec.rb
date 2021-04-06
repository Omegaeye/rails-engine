require 'rails_helper'

RSpec.describe "Api::V1::Merchants", type: :request do
  describe "GET /index" do
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

    describe "GET /index" do
      before :each do
        create_list(:merchant, 50)
      end

      it "renders a successful response" do
        get api_v1_merchants_url, headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].class).to eq(Array)
        expect(body[:data].first.class).to eq(Hash)
      end

      it "renders only 20" do
        get api_v1_merchants_url, headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].size).to eq(20)
      end

      it "renders pages" do
        get "/api/v1/merchants?page=1", headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].size).to eq(20)
        expect(body[:data].first[:id]).to eq("101")
        expect(body[:data].last[:id]).to eq("120")
      end

      it "renders pages" do
        merchants = Merchant.all
        get "/api/v1/merchants?page=2", headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].size).to eq(20)
        expect(body[:data]).to_not be_empty
        expect(body[:data].first[:id].to_i).to_not eq(merchants.first.id)
        expect(body[:data].first[:id].to_i).to eq(merchants[20].id)
        expect(body[:data].last[:id].to_i).to eq(merchants[39].id)
        expect(body[:data].size).to eq(20)
      end

      it 'return 50 merchants per page' do
        merchants = Merchant.all
        get '/api/v1/merchants?per_page=50', headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)
        expect(body[:data].size).to eq(50)
        expect(body[:data].first[:id].to_i).to eq(merchants.first.id)
        expect(body[:data].last[:id].to_i).to eq(merchants[49].id)
      end

      it 'still returns all merchants if per_page is greater than all merchants' do
        merchants = Merchant.all
        get '/api/v1/merchants?per_page=51', headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)
        expect(body[:data].size).to eq(51)
        expect(body[:data].first[:id].to_i).to eq(merchants.first.id)
        expect(body[:data].last[:id].to_i).to eq(merchants.last.id)
      end

      it 'returns the correct amount per page with given param' do
        merchants = Merchant.all
        get '/api/v1/merchants?per_page=15', headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)
        expect(body[:data].size).to eq(15)
        expect(body[:data].first[:id].to_i).to eq(merchants[0].id)
        expect(body[:data].last[:id].to_i).to eq(merchants[14].id)
      end

      it 'last page doesnt break if there arent 20 merchants to display' do
        merchants = Merchant.all
        get '/api/v1/merchants?page=3&per_page=20', headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)
        expect(body[:data].size).to eq(12)
        expect(body[:data].first[:id].to_i).to eq(merchants[40].id)
        expect(body[:data].last[:id].to_i).to eq(merchants[49].id)
      end

      it 'calling a pge that doesnt have any merchants wont break it' do
        merchants = Merchant.all
        get '/api/v1/merchants?page=7', headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)
        expect(body[:data].size).to eq(0)
      end
    end

    describe "GET /show" do
      it "renders a successful response" do
        merchant = Merchant.create! valid_attributes
        get api_v1_merchant_url(merchant), headers: valid_headers, as: :json
        expect(response).to be_successful
      end
    end

    describe 'get /api/v1/merchant/:id sad path' do
      it 'bad id returns a 404' do
        Merchant.create! valid_attributes
        get "/api/v1/merchants/21", headers: valid_headers, as: :json
        expect(response).to have_http_status(404)
      end
    end

    describe "POST /create" do
      context "with valid parameters" do
        it "creates a new Api::V1::Merchant" do
          expect {
            post api_v1_merchants_url,
                 params: { name: Faker::Name.name }, headers: valid_headers, as: :json
          }.to change(Merchant, :count).by(1)
        end

        it "renders a JSON response with the new api/v1_merchant" do
          post api_v1_merchants_url,
               params: { name: Faker::Name.name }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:created)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end

      context "with invalid parameters" do
        it "does not create a new Api::V1::Merchant" do
          expect {
            post api_v1_merchants_url,
                 params: { name: '' }, headers: valid_headers, as: :json
          }.to change(Merchant, :count).by(0)
        end

        it "renders a JSON response with errors for the new api/v1_merchant" do
          post api_v1_merchants_url,
               params: { name: '' }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq("application/json")
        end
      end
    end

    describe "PATCH /update" do
      context "with valid parameters" do

        it "updates the requested api/v1_merchant" do
          merchant = Merchant.create! valid_attributes
          patch api_v1_merchant_url(merchant),
                params: { name: "Help Me" }, headers: valid_headers, as: :json
          merchant.reload
          expect(merchant.name).to eq("Help Me")
        end

        it "renders a JSON response with the api/v1_merchant" do
          merchant = Merchant.create! valid_attributes
          patch api_v1_merchant_url(merchant),
                params: { name: "Help Me" }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end

      context "with invalid parameters" do
        it "renders a JSON response with errors for the api/v1_merchant" do
          merchant = Merchant.create! valid_attributes
          patch api_v1_merchant_url(merchant),
                params: { name: '' }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq("application/json")
        end
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested api/v1_merchant" do
        merchant = Merchant.create! valid_attributes
        expect {
          delete api_v1_merchant_url(merchant), headers: valid_headers, as: :json
        }.to change(Merchant, :count).by(-1)
      end
    end


  end
end
