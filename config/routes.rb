Rails.application.routes.draw do

  resources :order_items
  resources :items
  resources :orders
  resources :accounts
  devise_for :users

  root 'users#home'

  get "/account/:id/orders", to: "accounts#orders", as: "user_account"
  get "/account/:id/payment", to: "accounts#payment", as: "user_payment"
  post "/account/:id/payment", to: "accounts#create_payment", as: "user_create_payment"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
