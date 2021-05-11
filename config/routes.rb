Rails.application.routes.draw do
  get 'orders/index'
  get 'orders/show'
  root to: 'listings#index'
  devise_for :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :listings do
    resources :order_items, only: [:create]
  end
  get '/my-cart', to: 'order_items#my_cart'
  get '/my-listings', to: 'listings#my_listings'
end
