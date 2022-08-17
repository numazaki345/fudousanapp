Rails.application.routes.draw do
  devise_for :users, controllers: {
    # deviseの階層を編集した場合は適宜pathを編集してください
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'buildings#index'
  resources :buildings
  resources :rooms, only: [:show, :destroy]

  resources :buildings do
    resources :rooms, only: [:create]
  end
end
