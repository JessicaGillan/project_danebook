Rails.application.routes.draw do

  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  root 'users#new'

  resources :users do
    resource  :profile, only: [:show, :edit, :update]
    resources :posts, only: [:show, :create, :edit, :update, :destroy]
    resources :photos, only: [:new, :create, :show, :index, :destroy]
  end

  resource  :session

  resources :posts do
    resources :likes,    :defaults => { likable: 'Post' },
                         only: [:index, :create, :destroy]
    resources :comments, :defaults => { commentable: 'Post'},
                         only: [:create, :destroy]
  end

  resources :photos do
    resources :likes,    :defaults => { likable: 'Photo' },
                         only: [:index, :create, :destroy]
    resources :comments, :defaults => { commentable: 'Photo'},
                         only: [:index, :create, :destroy]
  end

  resources :comments do
    resources :likes, :defaults => { likable: 'Comment' },
                      only: [:index, :create, :destroy]
  end

  resources :friendings, only: [:create, :destroy, :index]
end
