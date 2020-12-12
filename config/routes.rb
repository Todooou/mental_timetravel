Rails.application.routes.draw do
  
  devise_for :users,
  controllers: {
    omniauth_callbacks: "users/omniauth_callbacks",
    registrations: "users/registrations"
  }
  get"/mypage" =>"users#mypage"

  get "top" => "posts#top"
  root to: "posts#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts, except: [:index]
  resources :relationships, only: [:create, :destroy]
  resources :tags, only: [:show]
  resources :users, only: [:index, :show, :edit, :update] do
  end
  get "users/:id/followers" => "users#followers" ,as: :followers
  get "users/:id/followings" => "users#followings" ,as: :followings 
end