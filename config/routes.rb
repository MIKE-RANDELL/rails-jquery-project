Rails.application.routes.draw do
  resources :order_items
  resources :items
  resources :orders
  resources :accounts
  devise_for :users, controllers: {omniauth_callbacks: "callbacks"}

  root 'users#home'


  get "/account/:id/payment", to: "accounts#payment", as: "user_payment"
  post "/account/:id/payment", to: "accounts#create_payment", as: "user_create_payment"
  get "/account/:id/pallets", to: "accounts#pallets", as: "user_pallets"
  post "/account/:id/pallets", to: "accounts#return_pallets", as: "user_return_pallets"

  get "/books", to: "accounts#books", as: "books"

  get "/account/:id/orders", to: "accounts#orders", as: "user_account"     #regular action


  get "/books/orders", to: "accounts#books_orders", as: "books_orders"
  post "/notes", to: "notes#api_create"#, as: "notes"
  get "/api/next_note/:accid/:noteid", to: "notes#api_show_next"
  get "/api/previous_note/:accid/:noteid", to: "notes#api_show_previous"

  #get "/api/account/:id", to: "accounts#api_account"
end
