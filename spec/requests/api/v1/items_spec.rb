require 'rails_helper'

RSpec.describe "Api::V1::Items", type: :request do
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

    describe "GET /index" do
      before :each do
        create_list(:item, 90)
      end

      it "renders a successful response" do
        get api_v1_items_url, headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].class).to eq(Array)
        expect(body[:data].first.class).to eq(Hash)
      end

      it "renders only 20" do
        get api_v1_items_url, headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].size).to eq(20)
      end

      it "renders pages" do
        get "/api/v1/items?page=1", headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].size).to eq(20)
        expect(body[:data].first[:id]).to eq("181")
        expect(body[:data].last[:id]).to eq("200")
      end

      it "renders pages" do
        items = Item.all
        get "/api/v1/items?page=2", headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(body[:data].size).to eq(20)
        expect(body[:data]).to_not be_empty
        expect(body[:data].first[:id].to_i).to_not eq(items.first.id)
        expect(body[:data].first[:id].to_i).to eq(items[20].id)
        expect(body[:data].last[:id].to_i).to eq(items[39].id)
      end

      it 'return 50 items per page' do
        items = Item.all
        get '/api/v1/items?per_page=50', headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)
        expect(body[:data].size).to eq(50)
        expect(body[:data].first[:id].to_i).to eq(items.first.id)
        expect(body[:data].last[:id].to_i).to eq(items[49].id)
      end

      it 'still returns all items if per_page is greater than all items' do
        items = Item.all
        get '/api/v1/items?per_page=101', headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)
        expect(body[:data].size).to eq(90)
        expect(body[:data].first[:id].to_i).to eq(items.first.id)
        expect(body[:data].last[:id].to_i).to eq(items.last.id)
      end

      it 'returns the correct amount per page with given param' do
        items = Item.all
        get '/api/v1/items?per_page=15', headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)
        expect(body[:data].size).to eq(15)
        expect(body[:data].first[:id].to_i).to eq(items[0].id)
        expect(body[:data].last[:id].to_i).to eq(items[14].id)
      end

      it 'last page doesnt break if there arent 20 items to display' do
        items = Item.all
        get '/api/v1/items?page=5&per_page=20', headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)
        expect(body[:data].size).to eq(10)
        expect(body[:data].first[:id].to_i).to eq(items[80].id)
        expect(body[:data].last[:id].to_i).to eq(items[89].id)
      end

      it 'calling a pge that doesnt have any items wont break it' do
        items = Item.all
        get '/api/v1/items?page=7', headers: valid_headers, as: :json
        expect(response).to be_successful
        body = JSON.parse(response.body, symbolize_names: true)
        expect(response).to have_http_status(200)
        expect(body[:data].size).to eq(0)
      end
    end

    describe "GET /show" do
      it "renders a successful response" do
        @merchant = Merchant.create(name: 'Crystal r Us')
        item = @merchant.items.create! valid_attributes
        get api_v1_item_url(item), headers: valid_headers, as: :json
        expect(response).to be_successful
      end
    end

    describe 'get /api/v1/item/:id sad path' do
      it 'bad id returns a 404' do
        @merchant = Merchant.create(name: 'Crystal r Us')
        item = @merchant.items.create! valid_attributes
        get "/api/v1/items/21", headers: valid_headers, as: :json
        expect(response).to have_http_status(404)
      end
    end

    # describe "POST /create" do
    #   context "with valid parameters" do
    #     it "creates a new Api::V1::Item" do
    #       expect {
    #         post "api/v1/items",
    #              params: { name: Faker::Vehicle.make,
    #               description: Faker::Vehicle.model,
    #               unit_price: 200.00,
    #               merchant_id: 43 }, headers: valid_headers, as: :json
    #       }.to change(Item, :count).by(1)
    #     end
    #
    #     it "renders a JSON response with the new api/v1_item" do
    #       post api_v1_items_url,
    #            params: { name: Faker::Vehicle.make,
    #             description: Faker::Vehicle.model,
    #             unit_price: 200,
    #             merchant_id: 1 }, headers: valid_headers, as: :json
    #       expect(response).to have_http_status(:created)
    #       expect(response.content_type).to match(a_string_including("application/json"))
    #     end
    #   end

      # context "with invalid parameters" do
        it "does not create a new Api::V1::Item" do
          expect {
            post api_v1_items_url,
                 params: { name: '' }, headers: valid_headers, as: :json
          }.to change(Item, :count).by(0)
        end

    #     it "renders a JSON response with errors for the new api/v1_item" do
    #       post api_v1_items_url,
    #            params: { name: '' }, headers: valid_headers, as: :json
    #       expect(response).to have_http_status(:unprocessable_entity)
    #       expect(response.content_type).to eq("application/json")
    #     end
    #   end
    # end

    describe "PATCH /update" do
      context "with valid parameters" do

        it "updates the requested api/v1_item" do
          item = @merchant = Merchant.create(name: 'Crystal r Us')
          item = @merchant.items.create! valid_attributes
          patch api_v1_item_url(item),
                params: { name: "Help Me" }, headers: valid_headers, as: :json
          item.reload
          expect(item.name).to eq("Help Me")
        end

        it "renders a JSON response with the api/v1_item" do
          item = @merchant = Merchant.create(name: 'Crystal r Us')
          item = @merchant.items.create! valid_attributes
          patch api_v1_item_url(item),
                params: { name: "Help Me" }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:ok)
          expect(response.content_type).to match(a_string_including("application/json"))
        end
      end

      context "with invalid parameters" do
        it "renders a JSON response with errors for the api/v1_item" do
          item = @merchant = Merchant.create(name: 'Crystal r Us')
          item = @merchant.items.create! valid_attributes
          patch api_v1_item_url(item),
                params: { name: '' }, headers: valid_headers, as: :json
          expect(response).to have_http_status(:unprocessable_entity)
          expect(response.content_type).to eq("application/json")
        end
      end
    end

    describe "DELETE /destroy" do
      it "destroys the requested api/v1_item" do
        @merchant = Merchant.create(name: 'Crystal r Us')
        @customer = Customer.create(first_name: 'Jennifer', last_name: 'Nguyen')
        @item1 = @merchant.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 5)
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

        # item = @merchant.items.create! valid_attributes
        expect(Invoice.find(@invoice1.id).present?).to eq(true)
        expect {
          delete api_v1_item_url(@item1), headers: valid_headers, as: :json
        }.to change(Item, :count).by(-1)
        expect(Invoice.find_by_id(@invoice1.id).present?).to eq(false)
        expect(Invoice.find_by_id(@invoice2.id).present?).to eq(true)
        expect(Invoice.find_by_id(@invoice3.id).present?).to eq(true)
        expect(Invoice.find_by_id(@invoice4.id).present?).to eq(false)
      end
    end


  end
end
