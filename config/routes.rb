Rails.application.routes.draw do

  resources :discounts
  root 'dashboard#index'

  resources :companies
  get 'bookings', to: 'bookings#index'
  get 'hello_world', to: 'hello_world#index'

  namespace :api do
    namespace :v1 do
      resources :syncs
    end
  end
end
