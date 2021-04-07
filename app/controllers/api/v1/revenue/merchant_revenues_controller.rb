class Api::V1::Revenue::MerchantRevenuesController < ApplicationController

  def index
    if !params[:quantity].present? || params[:quantity].to_i == 0
      render json: {data: [], error: 'errors'}, status: 400
    else
    @merchants = Merchant.top_by_revenue(params[:quantity])
    @serial = MerchantNameRevenueSerializer.new(@merchants)
    render json: @serial
    end
  end

  def show
    set_merchant
    @serial = MerchantRevenueSerializer.new(@merchant)
    render json: @serial
  end

  private

  def set_merchant
    @merchant = Merchant.find(params[:id])
  end
end
