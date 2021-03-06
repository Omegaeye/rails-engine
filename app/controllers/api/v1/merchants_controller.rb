class Api::V1::MerchantsController < ApplicationController
  before_action :set_merchant, only: [:show, :update, :destroy]
  # GET /merchants
  def index
    @merchants = Merchant.pagination_helper(params[:page].to_i, params[:per_page].to_i)
    @serial = MerchantSerializer.new(@merchants)
    render json: @serial
  end

  # GET /merchants/1
  def show
    @serial = MerchantSerializer.new(@merchant)
    render json: @serial, status: :ok
  end

  # POST /merchants
  def create
    @merchant = Merchant.new(merchant_params)
    if @merchant.save
      render json: @merchant, status: :created, location: api_v1_merchant_url(@merchant)
    else
      render json: @merchant.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /merchants/1
  def update
    if @merchant.update(merchant_params)
      render json: @merchant
    else
      render json: @merchant.errors, status: :unprocessable_entity
    end
  end

 # DELETE /merchants/1
  def destroy
    @merchant.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_merchant
    @merchant = Merchant.find(params[:id])
  end

  # Only allow a trusted parameter “white list” through.
  def merchant_params
    params.require(:merchant).permit(:name)
  end

end
