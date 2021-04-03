class Api::V1::Items::ItemMerchantController < ApplicationController
  before_action :set_item

  def index
    @merchant = @item.merchant
    @serial = MerchantSerializer.new(@merchant)
    render json: @serial
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

end
