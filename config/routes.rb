Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :users

  get "users/setting", to: "users#setting", as: :setting_user
  get "users/profile", to: "users#profile", as: :profile_user

  resources :users, only: [:index, :show]

  resources :matches, only: [:index, :create]

  resources :contacts, only: [:index]

  get "/chat", to: "chat#inbox", as: :inbox_chat

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
