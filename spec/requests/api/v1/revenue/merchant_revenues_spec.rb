require 'rails_helper'

RSpec.describe "Api::V1::Revenue::Revenues", type: :request do
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

    describe "GET /revenue/merchants" do
      it "Get 10 items" do
        @merchant = Merchant.create(name: 'Crystal r Us')
        @customer = Customer.create(first_name: 'Jennifer', last_name: 'Nguyen')
        @item1 = @merchant.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 5)
        @item2 = @merchant.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 10)
        @item3 = @merchant.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)

        @invoice1 = Invoice.create(customer: @customer, merchant: @merchant, status: 'shipped')
        @invoice2 = Invoice.create(customer: @customer, merchant: @merchant, status: 'shipped')
        @invoice3 = Invoice.create(customer: @customer, merchant: @merchant, status: 'shipped')
        @invoice4 = Invoice.create(customer: @customer, merchant: @merchant, status: 'shipped')

        @invoice_item1 = InvoiceItem.create(item: @item1, invoice: @invoice1, quantity: 100, unit_price: 100)
        @invoice_item2 = InvoiceItem.create(item: @item1, invoice: @invoice2, quantity: 100, unit_price: 100)
        @invoice_item3 = InvoiceItem.create(item: @item2, invoice: @invoice2, quantity: 100, unit_price: 100)
        @invoice_item4 = InvoiceItem.create(item: @item2, invoice: @invoice3, quantity: 100, unit_price: 100)
        @invoice_item5 = InvoiceItem.create(item: @item3, invoice: @invoice3, quantity: 100, unit_price: 100)
        @invoice_item6 = InvoiceItem.create(item: @item3, invoice: @invoice2, quantity: 100, unit_price: 100)
        @invoice_item7 = InvoiceItem.create(item: @item1, invoice: @invoice4, quantity: 100, unit_price: 100)

        @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
        @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
        @transaction3 = Transaction.create(invoice: @invoice3, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")

          get '/api/v1/revenue/merchants?quantity=10', headers: valid_headers, as: :json
          expect(response).to be_successful
          body = JSON.parse(response.body, symbolize_names: true)
          expect(body[:data].class).to eq(Array)
      end

      it "GET merchant with quantity of 1 to be 0" do
        @merchant = Merchant.create(name: 'Crystal r Us')
        @customer = Customer.create(first_name: 'Jennifer', last_name: 'Nguyen')
        @item1 = @merchant.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 5)
        @item2 = @merchant.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 10)
        @item3 = @merchant.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)

        @invoice1 = Invoice.create(customer: @customer, merchant: @merchant, status: 'shipped')
        @invoice2 = Invoice.create(customer: @customer, merchant: @merchant, status: 'shipped')
        @invoice3 = Invoice.create(customer: @customer, merchant: @merchant, status: 'shipped')
        @invoice4 = Invoice.create(customer: @customer, merchant: @merchant, status: 'shipped')

        @invoice_item1 = InvoiceItem.create(item: @item1, invoice: @invoice1, quantity: 100, unit_price: 100)
        @invoice_item2 = InvoiceItem.create(item: @item1, invoice: @invoice2, quantity: 100, unit_price: 100)
        @invoice_item3 = InvoiceItem.create(item: @item2, invoice: @invoice2, quantity: 100, unit_price: 100)
        @invoice_item4 = InvoiceItem.create(item: @item2, invoice: @invoice3, quantity: 100, unit_price: 100)
        @invoice_item5 = InvoiceItem.create(item: @item3, invoice: @invoice3, quantity: 100, unit_price: 100)
        @invoice_item6 = InvoiceItem.create(item: @item3, invoice: @invoice2, quantity: 100, unit_price: 100)
        @invoice_item7 = InvoiceItem.create(item: @item1, invoice: @invoice4, quantity: 100, unit_price: 100)

        @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
        @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
        @transaction3 = Transaction.create(invoice: @invoice3, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
        get '/api/v1/revenue/merchants?quantity=1', headers: valid_headers, as: :json
        body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)
        expect(body[:data].size).to eq(1)
        expect(body[:data].first[:attributes][:revenue].to_i).to eq(60000.00)
      end

      it "GET merchant with a string to be errored" do
        get '/api/v1/revenue/merchants?quantity=fasdfasd', headers: valid_headers, as: :json
        body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(400)
        expect(body[:data].size).to eq(0)
      end

      it "GET all merchants if quantity is to big" do
        @merchant = Merchant.create(name: 'Crystal r Us')
        @customer = Customer.create(first_name: 'Jennifer', last_name: 'Nguyen')
        @item1 = @merchant.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 5)
        @item2 = @merchant.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 10)
        @item3 = @merchant.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)

        @invoice1 = Invoice.create(customer: @customer, merchant: @merchant, status: 'shipped')
        @invoice2 = Invoice.create(customer: @customer, merchant: @merchant, status: 'shipped')
        @invoice3 = Invoice.create(customer: @customer, merchant: @merchant, status: 'shipped')
        @invoice4 = Invoice.create(customer: @customer, merchant: @merchant, status: 'shipped')

        @invoice_item1 = InvoiceItem.create(item: @item1, invoice: @invoice1, quantity: 100, unit_price: 100)
        @invoice_item2 = InvoiceItem.create(item: @item1, invoice: @invoice2, quantity: 100, unit_price: 100)
        @invoice_item3 = InvoiceItem.create(item: @item2, invoice: @invoice2, quantity: 100, unit_price: 100)
        @invoice_item4 = InvoiceItem.create(item: @item2, invoice: @invoice3, quantity: 100, unit_price: 100)
        @invoice_item5 = InvoiceItem.create(item: @item3, invoice: @invoice3, quantity: 100, unit_price: 100)
        @invoice_item6 = InvoiceItem.create(item: @item3, invoice: @invoice2, quantity: 100, unit_price: 100)
        @invoice_item7 = InvoiceItem.create(item: @item1, invoice: @invoice4, quantity: 100, unit_price: 100)

        @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
        @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
        @transaction3 = Transaction.create(invoice: @invoice3, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
        
        get '/api/v1/revenue/merchants?quantity=1', headers: valid_headers, as: :json
        body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)
        expect(body[:data].class).to eq(Array)
        expect(body[:data].first[:id].present?).to eq(true)
        expect(body[:data].first[:type].present?).to eq(true)
        expect(body[:data].first[:attributes].present?).to eq(true)
        expect(body[:data].first[:attributes][:name]).to eq("Crystal r Us")
        expect(body[:data].first[:attributes][:revenue]).to eq("60000.0")
      end
    end
  end
end
