Rails.application.routes.draw do

  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  root 'users#new'

  resources :users do
    resource  :profile, only: [:show, :new, :edit, :create, :update] do
      post '/:id/profile_photo' => 'profiles#add_profile_photo', as: 'profile_pic'
      post '/:id/cover_photo' => 'profiles#add_cover_photo', as: 'cover_pic'
    end
    resources :posts
    resources :photos
  end

  resource  :session

  resources :posts do
    resources :likes,    :defaults => { likable: 'Post' },
                         only: [:index, :create, :destroy]
    resources :comments, :defaults => { commentable: 'Post'},
                         only: [:index, :create, :destroy]
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
