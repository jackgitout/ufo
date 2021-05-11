Rails.application.routes.draw do
  root to: 'listings#index'
  devise_for :users

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :listings do
    resources :order_items, only: [:create]
  end
  get '/my-listings', to: 'listings#my_listings'
end
