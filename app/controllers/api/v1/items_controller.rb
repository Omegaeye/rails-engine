class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]

  # GET /items
  def index
    @items = Item.pagination_helper(params[:page].to_i, params[:per_page].to_i)
    @serial = ItemSerializer.new(@items)
    render json: @serial
  end

  # GET /items/1
  def show
    @serial = ItemSerializer.new(@item)
    render json: @serial, status: :ok
  end

  # POST /items
  def create
    @merchant = Merchant.find(params[:merchant_id])
    @item = @merchant.items.create(item_params)
    @serial = ItemSerializer.new(@item)
    if @item.save
      render json: @serial, status: :created, location: api_v1_item_url(@item)
    end
  end

  # PATCH/PUT /items/1
  def update
    @item.update!(item_params)
    @serial = ItemSerializer.new(@item)
    render json: @serial
  end

 # DELETE /items/1
  def destroy
    @item.invoices.delete_invoice
    @item.destroy
    render json: {status: 'SUCCESS', message: 'Deleted Item', data: @item}
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_item
    @item = Item.find(params[:id])
  end

  # Only allow a trusted parameter “white list” through.
  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end

end
