Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      resources :customers
      resources :invoice_items
      resources :transactions
      resources :items

      resources :merchants do
        get '/items', to: "merchant_items#index"

        get '/find', to: "merchants/search#index"
        member do
        end

        resources :invoices
      end
    end
  end
end
