class Api::V1::Merchants::SearchController < ApplicationController

  def index
    if Merchant.all.where('name ILIKE ?', "%#{params[:name]}%").empty?
      render json: {data: []}
    else
      @merchants = Merchant.where('name ILIKE ?', "%#{params[:name]}%").order(:name)
      @serial = MerchantSerializer.new(@merchants)
      render json: @serial
    end
  end

  def show
    if params[:name].nil? || params[:name].empty?
      render json: {data: {}}, status: 400
    elsif Merchant.all.where('name ILIKE ?', "%#{params[:name]}%").empty?
      render json: {data: {}}
    else
      @merchants = Merchant.all.where('name ILIKE ?', "%#{params[:name]}%")
      @serial = MerchantSerializer.new(@merchants.first)
      render json: @serial
    end
  end
end
