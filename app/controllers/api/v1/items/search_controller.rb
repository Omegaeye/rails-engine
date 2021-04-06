class Api::V1::Items::SearchController < ApplicationController

  def index
    if !params[:name].present?
      render json: {data: {}, error: 'error'}, status: 400
    else
      @items = Item.filter_by_name(params[:name])
      @serial = ItemSerializer.new(@items)
      render json: @serial
    end
  end

  def show
    @item = Item.where(nil)

    filtering_params(params).each do |key, value|
        @item = @item.public_send("filter_by_#{key}", value)
    end

    if @item.present?
      @serial = ItemSerializer.new(@item.first)
      render json: @serial
    else
      render json: {data: {}, error: 'error'}, status: 400
    end
  end

  private

  def filtering_params(params)
    params.permit(:name, :min_price, :max_price)
  end

end
