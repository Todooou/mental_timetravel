Rails.application.routes.draw do
  
  devise_for :users
  get '/mypage' => 'users#mypage'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "posts#new"
  get "top" => "posts#top"
  resources :users, only: [:index, :show, :edit, :update] 
  resources :posts, except: [:index]
  resources :relationships, only: [:create, :destroy]
end
