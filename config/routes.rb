Rails.application.routes.draw do
  get 'order_items/my_cart'
  get 'order_items/create'
  devise_for :users
  root to: 'pages#home'

  resources :order_items, only: [:my_cart, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
