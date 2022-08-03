Rails.application.routes.draw do
  # root to: 'buildings#index'
  root to: 'madoris#index'
  resources :buildings
  resources :madoris
end
