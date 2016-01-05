Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do

      resources :merchants, only: [:index,:show] do
        resources :items, only: [:index], module: "merchants"
        resources :invoices, only: [:index], module: "merchants"

        member do
          get :revenue
          get :favorite_customer
          get :customers_with_pending_invoices
        end

        collection do
          get 'find'
          get 'find_all'
          get 'random'
          get 'most_revenue'
          get 'most_items'
          get 'revenue', to: "merchants#total_revenue"
        end
      end

      get "customers/find", to: "customers#find", defaults: {format: :json }
      get "customers/find_all", to: "customers#find_all", defaults: {format: :json }
      get "customers/random", to: "customers#random", defaults: {format: :json }
      resources :customers,  only: [:index, :show], defaults: { format: :json }

      get "invoice_items/find", to: "invoice_items#find", defaults: { format: :json }
      get "invoice_items/find_all", to: "invoice_items#find_all", defaults: { format: :json }
      get "invoice_items/random", to: "invoice_items#random", defaults: { format: :json }
      resources :invoice_items,  only: [:index, :show], defaults: { format: :json }

      get "invoices/find", to: "invoices#find", defaults: { format: :json }
      get "invoices/find_all", to: "invoices#find_all", defaults: { format: :json }
      get "invoices/random", to: "invoices#random", defaults: { format: :json }
      resources :invoices,  only: [:index, :show], defaults: { format: :json }

      get "transactions/find", to: "transactions#find", defaults: { format: :json }
      get "transactions/find_all", to: "transactions#find_all", defaults: { format: :json }
      get "transactions/random", to: "transactions#random", defaults: { format: :json }
      resources :transactions,  only: [:index, :show], defaults: { format: :json }

      get "items/find", to: "items#find", defaults: { format: :json }
      get "items/find_all", to: "items#find_all", defaults: { format: :json }
      get "items/random", to: "items#random", defaults: { format: :json }
      resources :items,  only: [:index, :show], defaults: { format: :json }
    end
  end

end
