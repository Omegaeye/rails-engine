class Api::V1::Merchants::SearchController < ApplicationController
  before_action :params_check

  def index
    @merchants = Merchant.filter_by_name(params[:name]).order(:name)
    @serial = MerchantSerializer.new(@merchants)
    render json: @serial
  end

  def show
    @merchants = Merchant.filter_by_name(params[:name]).order(:name)
    if @merchants.empty?
        render json: {data: {}}, status: 400
    else
      @serial = MerchantSerializer.new(@merchants.first)
      render json: @serial
    end
  end

  private

  def params_check
    if !params[:name].present?
      render json: {data: {}}, status: 400
    end
  end
end
