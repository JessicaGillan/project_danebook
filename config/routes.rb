Rails.application.routes.draw do
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  root 'users#index'

  resources :users
  resource  :session
end
