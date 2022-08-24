Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?
  devise_for :users, controllers: {
    # deviseの階層を編集した場合は適宜pathを編集してください
    omniauth_callbacks: "users/omniauth_callbacks"
  }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'buildings#index'
  resources :buildings
  resources :rooms
  resources :clients
  resources :conditions
  resources :emails

  resources :clients do
    resources :conditions, only: [:create] do
      collection do
        get :complete
      end
    end
  end
  resources :buildings do
    resources :rooms, only: [:create]
  end
end
