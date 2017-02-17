Rails.application.routes.draw do

  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signout', to: 'sessions#destroy', as: 'signout'
  post 'spam', to: 'home#spam', as: 'send_spam'
  get 'apikey', to: 'home#sign_up', as: 'sign_up'

  resources :sessions, only: [:create, :destroy]
  resources :home, only: [:show]
  resources :uploads, only: [:index, :show, :create]

  root to: 'home#show'
  ### AWS
  get 'aws', to: 'aws#show'
  post 'start_ec2', to: 'aws#start_ec2', as: 'instance_info'
end
