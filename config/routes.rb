Rails.application.routes.draw do
  devise_for :users
  get '/mypage' => 'users#mypage'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "posts#new"
  resources :posts
  # routing for users
  resources :users, only: [:show, :edit, :update]
  resources :relationships, only: [:create, :destroy]
  
end
