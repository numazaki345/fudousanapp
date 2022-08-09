Rails.application.routes.draw do
  root to: 'buildings#index'
  resources :buildings
  resources :rooms, only: [:show, :destroy]

  resources :buildings do
    resources :rooms, only: [:create]
  end
end
