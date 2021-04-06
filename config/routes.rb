Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      # resources :customers
      # resources :invoice_items
      # resources :transactions
      # resources :invoices

      get '/items/find_all', to: "items/search#index"
      get '/items/find', to: "items/search#show"
      get '/merchants/find_all', to: "merchants/search#index"
      get '/merchants/find', to: "merchants/search#show"
      get '/revenue/merchants', to: "revenue/merchant_revenues#index"
      get '/revenue/merchants/:id', to: "revenue/merchant_revenues#show"
      resources :items

      get '/items/:id/merchant', to: "items/item_merchant#index"

      get 'merchants/most_items', to: "merchant_items#index"
      resources :merchants do
        get '/items', to: "merchant_items#show"
      end
    end
  end
end
