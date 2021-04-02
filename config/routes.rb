Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do

      resources :customers
      resources :invoice_items
      resources :transactions
      
      resources :merchants do
        resources :invoices
        resources :items
      end
    end

  end
end
