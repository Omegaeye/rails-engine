class Api::V1::MerchantItemsController < ApplicationController


  def index
    if !params[:quantity].present?
      render json: {data: [], error: 'error'}, status: 400
    else
      @merchants = Merchant.most_items_merchants(params[:quantity])
      @serial = MerchantMostItemsSerializer.new(@merchants)
      render json: @serial
    end
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @items = @merchant.items
    @serial = ItemSerializer.new(@items)
    render json: @serial
  end
end
