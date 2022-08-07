Rails.application.routes.draw do
  root to: 'buildings#index'
  resources :buildings
  resources :madoris

  resources :buildings do
    resources :madoris
  end
end
