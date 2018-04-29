Rails.application.routes.draw do
  mount ActionCable.server, at: '/cable'

  root 'dashboard#index'

  namespace :api do
    namespace :v1 do
      resources :syncs
    end
  end

  resources :discounts
  resources :clients
  # resources :documents
  # resources :employees
  # resources :vehicles
  # resources :locations
  # resources :uoms
  # resources :calculations
  # resources :kinds
  # resources :companies
  # get 'bookings', to: 'bookings#index'
  # get 'hello_world', to: 'hello_world#index'

end
