Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  post 'spam', to: 'home#spam', as: 'send_spam'
  get 'apikey', to: 'home#sign_up', as: 'sign_up'

  resources :sessions, only: [:create, :destroy]
  resources :home, only: [:show]

  root to: 'home#show'
end
