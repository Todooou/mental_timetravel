Rails.application.routes.draw do
  
  resources :posts
  resources :users, only: [:index, :show, :edit, :update] do
    resources :relationships, only: [:create, :destroy]
  end
  devise_for :users
  get '/mypage' => 'users#mypage'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: "posts#new"
  
end
