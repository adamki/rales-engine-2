Rails.application.routes.draw do

  namespace :api do
    namespace :v1 do
      resources :merchants
      resources :customers
    end
  end

end
