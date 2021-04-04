class Api::V1::Items::SearchController < ApplicationController

  def index
    if Item.all.where('name ILIKE ?', "%#{params[:name]}%").empty?
      render json: {data: []}
    else
      @items = Item.all.where('name ILIKE ?', "%#{params[:name]}%")
      @serial = ItemSerializer.new(@items)
      render json: @serial
    end
  end

  def show
    # # if params[:name] && (params[:min_price] || params[:max_price])
    # #   render json: {data: {}}
    # # end
    #
    # # if Item.all.where('name ILIKE ?', "%#{params[:name]}%").empty?
    # #  render json: {data: {}}
    # # end
    #
    # min_price = params[:min_price].to_i if !params[:min_price]  || params[:min_price].to_i < (1/0.0) && params[:min_price].to_i > 0
    # max_price = params[:max_price].to_i if !params[:max_price]  || params[:max_price].to_i < (1/0.0) && params[:max_price].to_i > 0
    #
    # require "pry"; binding.pry
    name = params[:name] if params[:name]
    if Item.all.where('name ILIKE ?', "%#{name}%").empty?
      render json: {data: {}}
    elsif params[:min_price] || params[:max_price]

      @items = Item.all.where(unit_price: price)
      @serial = ItemSerializer.new(@items.first)
      render json: @serial
    else
      @items = Item.all.where('name ILIKE ?', "%#{name}%")
      @serial = ItemSerializer.new(@items.first)
      render json: @serial
    end
  end

  # private

  # def item_by_price(price)
  #   price = params[:min_price].to_i if !params[:min_price]  || params[:min_price].to_i < (1/0.0) || params[:min_price].to_i > 0
  #   price = params[:max_price].to_i if !params[:max_price]  || params[:max_price].to_i < (1/0.0) || params[:price].to_i > 0
  # end
  #
  # def items_errors(name, price)
  #   if name && price
  #     render json: {data: {}}
  #   end
  # end
end
