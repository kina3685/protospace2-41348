Rails.application.routes.draw do
  devise_for :users # Devise のルートを追加
  root to: "prototypes#index"
  resources :prototypes do
    resources :comments, only: [:create]
    
  end
  resources :users, only: [:show]
end
