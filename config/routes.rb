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
  # resources :employees
  # resources :vehicles
  # resources :locations
  # resources :uoms
  # resources :calculations
  # resources :kinds
  # resources :companies
  # get 'bookings', to: 'bookings#index'
  # get 'hello_world', to: 'hello_world#index'

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  post '/switch', to: 'sessions#switch'

  resources :deliveries
  resources :cargos

  get 'daily_report', to: 'payments#daily_report'
  get 'cargo_transaction', to: 'payments#cargo_transaction_report'
  get 'cargo_collect', to: 'payments#cargo_collect_report'

end
