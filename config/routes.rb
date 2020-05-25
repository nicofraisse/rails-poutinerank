Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  root to: 'pages#home'
  resources :restaurants do
    resources :reviews, only: [:index, :new, :create]
  end
  resources :reviews, except: [:index, :new, :create]
  resources :users, only: [:show]
end
