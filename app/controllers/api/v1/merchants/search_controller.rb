class Api::V1::Merchants::SearchController < ApplicationController
  
  def index
    if Merchant.where('name LIKE ?', "%#{params[:name].downcase}%").empty?
      render json: {data: {}}
    else
      @merchant = Merchant.where('name LIKE ?', "%#{params[:name].downcase}%")
      @serial = MerchantSerializer.new(@merchant.first)
      render json: @serial
    end
  end


end
