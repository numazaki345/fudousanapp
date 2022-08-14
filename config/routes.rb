Rails.application.routes.draw do
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')

  namespace :admin do
    resources :users
  end
  root to: 'buildings#index'
  resources :buildings
  resources :rooms, only: [:show, :destroy]

  resources :buildings do
    resources :rooms, only: [:create]
  end
end
