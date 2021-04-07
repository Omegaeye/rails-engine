require 'rails_helper'

RSpec.describe "Api::V1::MerchantItems", type: :request do
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
        @merchant = Merchant.create(name: 'Crystal r Us')
        @customer = Customer.create(first_name: 'Jennifer', last_name: 'Nguyen')
        @item1 = @merchant.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 5, id: 1)
        @item2 = @merchant.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 10)
        @item3 = @merchant.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)

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
      end

      it "renders a successful response" do
        get '/api/v1/items/1/merchant', headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].class).to eq(Hash)
        expect(body[:data][:id].present?).to eq(true)
        expect(body[:data][:type].present?).to eq(true)
        expect(body[:data][:attributes].present?).to eq(true)
      end
    end
  end
end
