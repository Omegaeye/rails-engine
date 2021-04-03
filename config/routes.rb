Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      resources :customers
      resources :invoice_items
      resources :transactions
      resources :invoices
      resources :items

      get '/items/:id/merchant', to: "items/item_merchant#index"
      get '/items/find_all', to: "items/search#index"

      get '/merchants/find', to: "merchants/search#index"

      resources :merchants do
        get '/items', to: "merchant_items#index"
      end
    end
  end
end
