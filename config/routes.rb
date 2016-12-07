Rails.application.routes.draw do
  get 'login', to: 'session#new'

  root 'users#index'

  resources :users
  resource  :session
end
