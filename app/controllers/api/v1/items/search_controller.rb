class Api::V1::Items::SearchController < ApplicationController

  def index
    require "pry"; binding.pry
    if Item.where('name LIKE ?', "%#{params[:name].downcase}%").empty?
      render json: {data: {}}
    else
      @item = Item.where('name LIKE ?', "%#{params[:name].downcase}%")
      @serial = ItemSerializer.new(@item.first)
      render json: @serial
    end
  end

end
