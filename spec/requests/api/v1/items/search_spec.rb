require 'rails_helper'

RSpec.describe "Api::V1::Items::Searches", type: :request do
  describe "GET /index" do
    let(:valid_attributes) {
    {name: Faker::Vehicle.make,
     description: Faker::Vehicle.model,
     unit_price: 200}
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
    describe "Get/api/v1/items/find_all?" do
      it "find_all name = uArt" do
        @merchant = Merchant.create(name: 'Crystal r Us')
        @customer = Customer.create(first_name: 'Jennifer', last_name: 'Nguyen')
        @item1 = @merchant.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 50)
        @item2 = @merchant.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 100000)
        @item3 = @merchant.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 200000000)

        @invoice1 = Invoice.create(customer: @customer, merchant: @merchant, status: 0)
        @invoice2 = Invoice.create(customer: @customer, merchant: @merchant, status: 0)
        @invoice3 = Invoice.create(customer: @customer, merchant: @merchant, status: 0)
        @invoice4 = Invoice.create(customer: @customer, merchant: @merchant, status: 0)

        @invoice_item1 = InvoiceItem.create(item: @item1, invoice: @invoice1, quantity: 100, unit_price: 100)
        @invoice_item2 = InvoiceItem.create(item: @item1, invoice: @invoice2, quantity: 100, unit_price: 100)
        @invoice_item3 = InvoiceItem.create(item: @item2, invoice: @invoice2, quantity: 100, unit_price: 100)
        @invoice_item4 = InvoiceItem.create(item: @item2, invoice: @invoice3, quantity: 100, unit_price: 100)
        @invoice_item5 = InvoiceItem.create(item: @item3, invoice: @invoice3, quantity: 100, unit_price: 100)
        @invoice_item6 = InvoiceItem.create(item: @item3, invoice: @invoice2, quantity: 100, unit_price: 100)
        @invoice_item7 = InvoiceItem.create(item: @item1, invoice: @invoice4, quantity: 100, unit_price: 100)

        get '/api/v1/items/find_all?name=uArt', headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].size).to eq(1)
      end

      it "Get /find_all edge case" do
        get '/api/v1/items/find_all', headers: valid_headers, as: :json
        expect(response).to have_http_status(400)
      end

      it "Get /find_all edge case" do
        get '/api/v1/items/find_all?name=', headers: valid_headers, as: :json
        expect(response).to have_http_status(400)
      end
    end

    describe "GET /items/find " do
      it "get item name " do
        @merchant = Merchant.create(name: 'Crystal r Us')
        item = @merchant.items.create! valid_attributes
        get api_v1_item_url(item), headers: valid_headers, as: :json
        expect(response).to be_successful
      end

      it "Get /find edge case" do
        get '/api/v1/items/find', headers: valid_headers, as: :json
        expect(response).to have_http_status(400)
      end

      it "Get /find edge case" do
        get '/api/v1/items/find?name=', headers: valid_headers, as: :json
        expect(response).to have_http_status(400)
      end
    end

    describe "GET /items/find?min_price" do
      it "find items by min_price" do
        @merchant = Merchant.create(name: 'Crystal r Us')
        @customer = Customer.create(first_name: 'Jennifer', last_name: 'Nguyen')
        @item1 = @merchant.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 50)
        @item2 = @merchant.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 100000)
        @item3 = @merchant.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 200000000)
        get '/api/v1/items/find?min_price=50'
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data][:id].present?).to eq(true)
        expect(body[:data][:type].present?).to eq(true)
        expect(body[:data][:attributes][:name].present?).to eq(true)
        expect(body[:data][:attributes][:description].present?).to eq(true)
        expect(body[:data][:attributes][:unit_price].present?).to eq(true)
        expect(body[:data][:attributes][:merchant_id].present?).to eq(true)
      end

      it "error response for min_price to large" do
        @merchant = Merchant.create(name: 'Crystal r Us')
        @customer = Customer.create(first_name: 'Jennifer', last_name: 'Nguyen')
        @item1 = @merchant.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 50)
        @item2 = @merchant.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 100000)
        @item3 = @merchant.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 200000000)
        get '/api/v1/items/find?min_price=500000000'
        expect(response).to have_http_status(400)
      end
    end

    describe "Get /item/find?max_price" do
      it "happy path" do
        @merchant = Merchant.create(name: 'Crystal r Us')
        @customer = Customer.create(first_name: 'Jennifer', last_name: 'Nguyen')
        @item1 = @merchant.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 50)
        @item2 = @merchant.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 100000)
        @item3 = @merchant.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 200000000)
        get '/api/v1/items/find?max_price=100000'
        expect(response).to have_http_status(200)
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data][:id].present?).to eq(true)
        expect(body[:data][:type].present?).to eq(true)
        expect(body[:data][:attributes][:name].present?).to eq(true)
        expect(body[:data][:attributes][:description].present?).to eq(true)
        expect(body[:data][:attributes][:unit_price].present?).to eq(true)
        expect(body[:data][:attributes][:merchant_id].present?).to eq(true)
      end

      it "sad path" do
        @merchant = Merchant.create(name: 'Crystal r Us')
        @customer = Customer.create(first_name: 'Jennifer', last_name: 'Nguyen')
        @item1 = @merchant.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 50)
        @item2 = @merchant.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 100000)
        @item3 = @merchant.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 200000000)
        get '/api/v1/items/find?max_price=49'
        expect(response).to have_http_status(400)
      end

      it "sad path, less than 0" do
        @merchant = Merchant.create(name: 'Crystal r Us')
        @customer = Customer.create(first_name: 'Jennifer', last_name: 'Nguyen')
        @item1 = @merchant.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 50)
        @item2 = @merchant.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 100000)
        @item3 = @merchant.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 200000000)
        get '/api/v1/items/find?max_price=-5'
        expect(response).to have_http_status(400)
      end

      it "sad path, cannot send name and price" do
        @merchant = Merchant.create(name: 'Crystal r Us')
        @customer = Customer.create(first_name: 'Jennifer', last_name: 'Nguyen')
        @item1 = @merchant.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 50)
        @item2 = @merchant.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 100000)
        @item3 = @merchant.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 200000000)
        get '/api/v1/items/find?name=ring&max_price=50'
        expect(response).to have_http_status(400)
      end

      it "Edge case, min cannot be bigger than max" do
        @merchant = Merchant.create(name: 'Crystal r Us')
        @customer = Customer.create(first_name: 'Jennifer', last_name: 'Nguyen')
        @item1 = @merchant.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 50)
        @item2 = @merchant.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 100000)
        @item3 = @merchant.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 200000000)
        get '/api/v1/items/find?min_price=50&max_price=5'
        expect(response).to have_http_status(400)
      end
    end
  end
end
