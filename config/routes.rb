Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'registrations' }
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  root to: 'pages#home'
  resources :restaurants do
    resources :reviews, only: [:index, :new, :create]
  end
  resources :reviews, except: [:index, :new, :create]
  resources :users, only: [:show]
  get '/search', to: 'restaurants#search'
end
