Rails.application.routes.draw do
  devise_for :users
  get "/chat_rooms_user" => "chat_rooms#rooms_user"
  resources :chat_rooms
  mount ActionCable.server => '/cable'
  root 'chat_rooms#index'
  get "/users/show"
end