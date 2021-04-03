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
      it "renders a successful response" do
        Merchant.create! valid_attributes
        get api_v1_merchants_url, headers: valid_headers, as: :json
        expect(response).to be_successful
      end
    end

    describe "GET /show" do
      it "renders a successful response" do
        merchant = Merchant.create! valid_attributes
        get api_v1_merchant_url(merchant), headers: valid_headers, as: :json
        expect(response).to be_successful
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
