Rails.application.routes.draw do
  root to: 'listings#index'
  get 'orders/index'
  get 'orders/show'
  devise_for :users

  resources :listings do
    resources :order_items, only: [:create]
  end

  resources :order_items, only: [:destroy]

  resources :orders, only: [:index, :show, :create]

  get '/my-cart', to: 'order_items#my_cart'
  get '/my-listings', to: 'listings#my_listings'

end