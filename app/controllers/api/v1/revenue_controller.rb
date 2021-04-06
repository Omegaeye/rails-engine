class Api::V1::RevenueController < ApplicationController

  def index
    unless params[:start].present? && params[:end].present?
      render json: {data: [], error: 'error'}, status: 400
    else
      @revenue = RevenueAnalytic.new({start: params[:start], end: params[:end]})
      @serial = RevenueSerializer.new(@revenue)
      render json: @serial
    end
  end
end
