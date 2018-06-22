Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :users, controllers: {registrations: :registrations}

  get "users/setting", to: "users#setting", as: :setting_user
  get "users/profile", to: "users#profile", as: :profile_user

  resources :users, only: [:index, :show]

  resources :matches, only: [:index, :create]

  resources :contacts, only: [:index]

  get "/chat", to: "chat#inbox", as: :inbox_chat
  get "/chat/:id", to: "chat#room", as: :room_chat
  post "/chat/:id/send", to: "chat#send_message", as: :send_message_chat

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
