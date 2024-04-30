Rails.application.routes.draw do
  post 'login', to: 'sessions#create'
  post 'signup', to: 'users#create'

  resources :users, only: [:show, :update, :destroy]
  resources :employees
  resources :teams
end
