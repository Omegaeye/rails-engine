class Api::V1::Merchants::SearchController < ApplicationController
before_action :set_page, only: [:index]

  def index
    @merchants = Merchant.order(created_at: :desc).offset(@page * 50)
  end


end
