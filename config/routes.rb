Rails.application.routes.draw do

  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  root 'users#new'

  resources :users do
    resource  :profile, only: [:show, :new, :edit, :create, :update]
    resources :posts
  end

  resource  :session

  resources :posts do
    resources :likes, :defaults => { :likable => 'Post' },
                      only: [:index, :create, :destroy]
  end
end
