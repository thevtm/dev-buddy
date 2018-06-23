Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :users, controllers: {registrations: :registrations}

  get "my_profile/", to: "users#my_profile", as: :my_profile_user
  get "setting/",    to: "users#setting",    as: :setting_user
  get "users/:id",   to: "users#show",       as: :profile_user

  get  "match/", to: "matches#index", as: :matches
  post "match/", to: "matches#create"

  get  "chat/",         to: "chat#inbox",        as: :inbox_chat
  get  "chat/:id",      to: "chat#room",         as: :room_chat
  post "chat/:id/send", to: "chat#send_message", as: :send_message_chat

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
