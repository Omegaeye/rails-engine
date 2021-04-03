class Api::V1::MerchantItemsController < ApplicationController
  before_action :set_merchant

  def index
      @items = @merchant.items
      @serial = ItemSerializer.new(@items)
      render json: @serial
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:merchant_id])
  end
end
