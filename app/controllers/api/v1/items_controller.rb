class Api::V1::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :update, :destroy]
  before_action :set_page, only: :index

  # GET /items
  def index
    @items = if params[:page] && params[:per_page]
                     Item.all.limit(params[:per_page].to_i).offset(params[:per_page].to_i * (@page - 1))
                   elsif params[:page] && !params[:per_page]
                      Item.all.limit(20).offset(20 * (@page.to_i - 1))
                   elsif !params[:page] && params[:per_page]
                      Item.all.limit(params[:per_page].to_i).offset(params[:per_page].to_i * 0)
                   else
                      Item.all.limit(20)
                   end

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
   else
    render json: {status: 'ERROR', message: 'Item not saved', data: @item.errors}, status: :unprocessable_entity
   end
  end

  # PATCH/PUT /items/1
  def update
   if @item.update(item_params)
     @serial = ItemSerializer.new(@item)
    render json: @serial
   else
    render json: @item.errors, status: 404
   end
  end

 # DELETE /items/1
  def destroy
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

  def set_page
    params[:page].to_i < 1 ? @page = 1 : @page = params[:page].to_i
  end
end
