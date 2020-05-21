Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :restaurants do
    resources :reviews, only: [:index, :new, :create]
  end
  resources :reviews, except: [:index, :new, :create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
