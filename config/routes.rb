Rails.application.routes.draw do
  
  devise_for :users,
  controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  get "/mypage" => "users#mypage"
  get "top" => "posts#top"
  root to: "posts#top"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :users, only: [:index, :show, :edit, :update] do
    resources :tags, only: [:show]
  end
  resources :posts, except: [:index]
  resources :relationships, only: [:create, :destroy]
end