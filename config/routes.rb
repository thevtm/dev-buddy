Rails.application.routes.draw do

  root to: 'pages#home'

  devise_for :users

  get "users/setting", to: "users#setting", as: :setting_user

  resources :users, only: [:index, :show] do
    resources :matches, only: [:index, :create, :show]

  end



  resources :contacts, only: [:index]

  get "/chat", to: "chat#inbox", as: :inbox_chat

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
