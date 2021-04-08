require 'rails_helper'

RSpec.describe Merchant, type: :model do
  before :each do
    @merchant1 = Merchant.create(name: 'Crystal r Us', id: 1)
    @merchant2 = Merchant.create(name: 'Top Crystals')
    @merchant3 = Merchant.create(name: 'Peak Krysty')
    @merchant4 = Merchant.create(name: 'Beyond Rock')
    @merchant5 = Merchant.create(name: 'Rock Beyond')
    @merchant6 = Merchant.create(name: 'Cystal Krystal')
    @merchant7 = Merchant.create(name: 'Coffee N Crystal')
    @merchant8 = Merchant.create(name: 'WTF Coffee')

    @customer = Customer.create(first_name: 'Jennifer', last_name: 'Nguyen')
    @customer2 = Customer.create(first_name: 'Dmytri', last_name: 'Nguyen')

    @item1 = @merchant1.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 5)
    @item2 = @merchant1.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 10)
    @item3 = @merchant1.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)
    @item4 = @merchant1.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 5)
    @item5 = @merchant2.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 10)
    @item6 = @merchant2.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)
    @item7 = @merchant2.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 5)
    @item8 = @merchant2.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 10)
    @item9 = @merchant3.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)
    @item10 = @merchant3.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 5)
    @item11 = @merchant3.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 10)
    @item12 = @merchant3.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)
    @item13 = @merchant3.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 5)
    @item14 = @merchant4.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 10)
    @item15 = @merchant4.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)
    @item16 = @merchant4.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 5)
    @item17 = @merchant4.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 10)
    @item18 = @merchant5.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)
    @item19 = @merchant5.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 5)
    @item20 = @merchant5.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 10)
    @item21 = @merchant5.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)
    @item22 = @merchant6.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 5)
    @item23 = @merchant6.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 10)
    @item24 = @merchant6.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)
    @item25 = @merchant6.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)
    @item26 = @merchant7.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 5)
    @item27 = @merchant7.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 10)
    @item28 = @merchant7.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)
    @item29 = @merchant7.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)
    @item30 = @merchant8.items.create(name: 'Blood Stone', description: 'Ruby Color', unit_price: 5)
    @item31 = @merchant8.items.create(name: 'Rose Quartz', description: 'Pink Color', unit_price: 10)
    @item32 = @merchant8.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)
    @item33 = @merchant8.items.create(name: 'Tigers Eye', description: 'Brown/Gold', unit_price: 20)

    @invoice1 = Invoice.create(customer: @customer, merchant: @merchant1, status: 'shipped')
    @invoice2 = Invoice.create(customer: @customer, merchant: @merchant1, status: 'shipped', created_at: Date.yesterday)
    @invoice3 = Invoice.create(customer: @customer, merchant: @merchant1, status: 'shipped', created_at: Date.yesterday)
    @invoice4 = Invoice.create(customer: @customer, merchant: @merchant1, status: 'shipped', created_at: Date.yesterday)
    @invoice5 = Invoice.create(customer: @customer, merchant: @merchant2, status: 'shipped', created_at: 7.days.ago)
    @invoice6 = Invoice.create(customer: @customer, merchant: @merchant2, status: 'shipped', created_at: 7.days.ago)
    @invoice7 = Invoice.create(customer: @customer, merchant: @merchant2, status: 'shipped', created_at: 7.days.ago)
    @invoice8 = Invoice.create(customer: @customer, merchant: @merchant2, status: 'shipped', created_at: 7.days.ago)
    @invoice9 = Invoice.create(customer: @customer, merchant: @merchant3, status: 'shipped', created_at: 7.days.ago)
    @invoice10 = Invoice.create(customer: @customer, merchant: @merchant3, status: 'shipped', created_at: 7.days.ago)
    @invoice11 = Invoice.create(customer: @customer, merchant: @merchant3, status: 'shipped', created_at: 7.days.ago)
    @invoice12 = Invoice.create(customer: @customer, merchant: @merchant3, status: 'shipped', created_at: 7.days.ago)
    @invoice13 = Invoice.create(customer: @customer, merchant: @merchant4, status: 'shipped', created_at: 4.days.ago)
    @invoice14 = Invoice.create(customer: @customer, merchant: @merchant4, status: 'shipped', created_at: 4.days.ago)
    @invoice15 = Invoice.create(customer: @customer, merchant: @merchant4, status: 'shipped', created_at: 4.days.ago)
    @invoice16 = Invoice.create(customer: @customer, merchant: @merchant4, status: 'shipped', created_at: 4.days.ago)
    @invoice17 = Invoice.create(customer: @customer, merchant: @merchant5, status: 'shipped', created_at: 4.days.ago)
    @invoice18 = Invoice.create(customer: @customer, merchant: @merchant5, status: 'shipped', created_at: 4.days.ago)
    @invoice19 = Invoice.create(customer: @customer, merchant: @merchant5, status: 'shipped', created_at: 4.days.ago)
    @invoice20 = Invoice.create(customer: @customer, merchant: @merchant5, status: 'shipped', created_at: 4.days.ago)
    @invoice21 = Invoice.create(customer: @customer, merchant: @merchant6, status: 'shipped', created_at: 4.days.ago)
    @invoice22 = Invoice.create(customer: @customer, merchant: @merchant6, status: 'shipped', created_at: 4.days.ago)
    @invoice23 = Invoice.create(customer: @customer, merchant: @merchant6, status: 'shipped', created_at: 2.days.ago)
    @invoice24 = Invoice.create(customer: @customer, merchant: @merchant6, status: 'shipped', created_at: 2.days.ago)
    @invoice25 = Invoice.create(customer: @customer, merchant: @merchant7, status: 'shipped', created_at: 2.days.ago)
    @invoice26 = Invoice.create(customer: @customer, merchant: @merchant7, status: 'shipped', created_at: 2.days.ago)
    @invoice27 = Invoice.create(customer: @customer, merchant: @merchant7, status: 'shipped', created_at: 2.days.ago)
    @invoice28 = Invoice.create(customer: @customer, merchant: @merchant7, status: 'shipped', created_at: 2.days.ago)
    @invoice29 = Invoice.create(customer: @customer, merchant: @merchant8, status: 'shipped', created_at: 2.days.ago)
    @invoice30 = Invoice.create(customer: @customer, merchant: @merchant8, status: 'shipped', created_at: 2.days.ago)
    @invoice31 = Invoice.create(customer: @customer, merchant: @merchant8, status: 'shipped', created_at: 2.days.ago)
    @invoice32 = Invoice.create(customer: @customer, merchant: @merchant8, status: 'shipped', created_at: 2.days.ago)

    @invoice_item1 = InvoiceItem.create(item: @item1, invoice: @invoice1, quantity: 100, unit_price: 100)
    @invoice_item2 = InvoiceItem.create(item: @item2, invoice: @invoice1, quantity: 100, unit_price: 100)
    @invoice_item3 = InvoiceItem.create(item: @item1, invoice: @invoice2, quantity: 100, unit_price: 100)
    @invoice_item4 = InvoiceItem.create(item: @item2, invoice: @invoice2, quantity: 100, unit_price: 100)
    @invoice_item5 = InvoiceItem.create(item: @item1, invoice: @invoice3, quantity: 100, unit_price: 100)
    @invoice_item6 = InvoiceItem.create(item: @item3, invoice: @invoice3, quantity: 100, unit_price: 100)
    @invoice_item7 = InvoiceItem.create(item: @item1, invoice: @invoice4, quantity: 100, unit_price: 100)
    @invoice_item8 = InvoiceItem.create(item: @item3, invoice: @invoice4, quantity: 100, unit_price: 100)
    @invoice_item9 = InvoiceItem.create(item: @item1, invoice: @invoice5, quantity: 100, unit_price: 100)
    @invoice_item10 = InvoiceItem.create(item: @item3, invoice: @invoice5, quantity: 100, unit_price: 100)

    @invoice_item11 = InvoiceItem.create(item: @item4, invoice: @invoice6, quantity: 100, unit_price: 100)
    @invoice_item12 = InvoiceItem.create(item: @item5, invoice: @invoice7, quantity: 100, unit_price: 100)
    @invoice_item13 = InvoiceItem.create(item: @item6, invoice: @invoice8, quantity: 100, unit_price: 100)
    @invoice_item14 = InvoiceItem.create(item: @item7, invoice: @invoice9, quantity: 100, unit_price: 100)
    @invoice_item15 = InvoiceItem.create(item: @item8, invoice: @invoice10, quantity: 100, unit_price: 100)
    @invoice_item16 = InvoiceItem.create(item: @item9, invoice: @invoice11, quantity: 100, unit_price: 100)
    @invoice_item17 = InvoiceItem.create(item: @item10, invoice: @invoice12, quantity: 100, unit_price: 100)
    @invoice_item18 = InvoiceItem.create(item: @item11, invoice: @invoice13, quantity: 100, unit_price: 100)
    @invoice_item19 = InvoiceItem.create(item: @item12, invoice: @invoice14, quantity: 100, unit_price: 100)
    @invoice_item20 = InvoiceItem.create(item: @item13, invoice: @invoice15, quantity: 100, unit_price: 100)

    @invoice_item21 = InvoiceItem.create(item: @item14, invoice: @invoice16, quantity: 100, unit_price: 100)
    @invoice_item22 = InvoiceItem.create(item: @item15, invoice: @invoice17, quantity: 100, unit_price: 100)
    @invoice_item23 = InvoiceItem.create(item: @item16, invoice: @invoice18, quantity: 100, unit_price: 100)
    @invoice_item24 = InvoiceItem.create(item: @item17, invoice: @invoice19, quantity: 100, unit_price: 100)
    @invoice_item25 = InvoiceItem.create(item: @item18, invoice: @invoice20, quantity: 100, unit_price: 100)
    @invoice_item26 = InvoiceItem.create(item: @item19, invoice: @invoice21, quantity: 100, unit_price: 100)
    @invoice_item27 = InvoiceItem.create(item: @item20, invoice: @invoice22, quantity: 100, unit_price: 100)
    @invoice_item28 = InvoiceItem.create(item: @item21, invoice: @invoice23, quantity: 100, unit_price: 100)
    @invoice_item29 = InvoiceItem.create(item: @item22, invoice: @invoice24, quantity: 100, unit_price: 100)
    @invoice_item30 = InvoiceItem.create(item: @item23, invoice: @invoice25, quantity: 100, unit_price: 100)

    @invoice_item31 = InvoiceItem.create(item: @item24, invoice: @invoice26, quantity: 100, unit_price: 100)
    @invoice_item32 = InvoiceItem.create(item: @item25, invoice: @invoice27, quantity: 100, unit_price: 100)
    @invoice_item33 = InvoiceItem.create(item: @item26, invoice: @invoice28, quantity: 100, unit_price: 100)
    @invoice_item34 = InvoiceItem.create(item: @item27, invoice: @invoice29, quantity: 100, unit_price: 100)
    @invoice_item35 = InvoiceItem.create(item: @item28, invoice: @invoice30, quantity: 100, unit_price: 100)
    @invoice_item36 = InvoiceItem.create(item: @item29, invoice: @invoice31, quantity: 100, unit_price: 100)
    @invoice_item37 = InvoiceItem.create(item: @item30, invoice: @invoice32, quantity: 100, unit_price: 100)
    @invoice_item38 = InvoiceItem.create(item: @item32, invoice: @invoice3, quantity: 100, unit_price: 100)
    @invoice_item39 = InvoiceItem.create(item: @item31, invoice: @invoice15, quantity: 100, unit_price: 100)
    @invoice_item40 = InvoiceItem.create(item: @item33, invoice: @invoice25, quantity: 100, unit_price: 100)

    @invoice_item41 = InvoiceItem.create(item: @item14, invoice: @invoice11, quantity: 100, unit_price: 100)
    @invoice_item42 = InvoiceItem.create(item: @item25, invoice: @invoice21, quantity: 100, unit_price: 100)
    @invoice_item43 = InvoiceItem.create(item: @item11, invoice: @invoice22, quantity: 100, unit_price: 100)
    @invoice_item44 = InvoiceItem.create(item: @item32, invoice: @invoice32, quantity: 100, unit_price: 100)
    @invoice_item45 = InvoiceItem.create(item: @item14, invoice: @invoice13, quantity: 100, unit_price: 100)
    @invoice_item46 = InvoiceItem.create(item: @item32, invoice: @invoice23, quantity: 100, unit_price: 100)
    @invoice_item47 = InvoiceItem.create(item: @item13, invoice: @invoice4, quantity: 100, unit_price: 100)
    @invoice_item48 = InvoiceItem.create(item: @item23, invoice: @invoice24, quantity: 100, unit_price: 100)
    @invoice_item49 = InvoiceItem.create(item: @item21, invoice: @invoice28, quantity: 100, unit_price: 100)
    @invoice_item50 = InvoiceItem.create(item: @item13, invoice: @invoice19, quantity: 100, unit_price: 100)


    @transaction1 = Transaction.create(invoice: @invoice1, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction2 = Transaction.create(invoice: @invoice2, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction3 = Transaction.create(invoice: @invoice3, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction4 = Transaction.create(invoice: @invoice4, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction5 = Transaction.create(invoice: @invoice5, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction6 = Transaction.create(invoice: @invoice6, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction7 = Transaction.create(invoice: @invoice7, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction8 = Transaction.create(invoice: @invoice8, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction9 = Transaction.create(invoice: @invoice9, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction10 = Transaction.create(invoice: @invoice10, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction11 = Transaction.create(invoice: @invoice11, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction12 = Transaction.create(invoice: @invoice12, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction13 = Transaction.create(invoice: @invoice13, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction14 = Transaction.create(invoice: @invoice14, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction15 = Transaction.create(invoice: @invoice15, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction16 = Transaction.create(invoice: @invoice16, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction17 = Transaction.create(invoice: @invoice17, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction18 = Transaction.create(invoice: @invoice18, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction19 = Transaction.create(invoice: @invoice19, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction20 = Transaction.create(invoice: @invoice20, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction21 = Transaction.create(invoice: @invoice21, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction22 = Transaction.create(invoice: @invoice22, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction23 = Transaction.create(invoice: @invoice23, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction24 = Transaction.create(invoice: @invoice24, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction25 = Transaction.create(invoice: @invoice25, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction26 = Transaction.create(invoice: @invoice26, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction27 = Transaction.create(invoice: @invoice27, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction28 = Transaction.create(invoice: @invoice28, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction29 = Transaction.create(invoice: @invoice29, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction30 = Transaction.create(invoice: @invoice30, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction31 = Transaction.create(invoice: @invoice31, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
    @transaction32 = Transaction.create(invoice: @invoice32, credit_card_number: '123456789', credit_card_expiration_date: '02/02', result: "success")
  end
  describe 'relationships' do
    it {should have_many :items}
    it {should have_many(:invoice_items).through(:items)}
    it {should have_many(:invoices).through(:invoice_items)}
    it {should have_many(:transactions).through(:invoices)}
    it {should have_many(:customers).through(:invoices)}
  end

  describe 'validations' do
    it {should validate_presence_of :name}
  end

  describe 'class methods' do
    describe '::revenue' do
      it 'returns merchant based on total revenue' do
        expect(@merchant1.revenue.to_f).to eq(110000.0)
      end

      it 'returns all merchants based on quantity given' do
        expect(Merchant.top_by_revenue(5).first).to eq(@merchant1)
      end
    end

    it "quantity of items sold" do
      expect(@merchant1.quantity_of_items_sold).to eq(1300)
    end

    it "most_items_merchants" do
      expect(Merchant.most_items_merchants(5)).to eq([@merchant1, @merchant3, @merchant8, @merchant4, @merchant6])
    end
  end
end
