Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'buildings#index'
  resources :buildings
  resources :rooms, only: [:show, :destroy]

  resources :buildings do
    resources :rooms, only: [:create]
  end
end
