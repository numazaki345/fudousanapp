Rails.application.routes.draw do
  root to: 'buildings#index'
  resources :buildings
  resources :madoris
end
