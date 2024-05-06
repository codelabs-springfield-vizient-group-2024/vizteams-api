Rails.application.routes.draw do
  post 'login', to: 'sessions#create'
  post 'signup', to: 'users#create'

  resources :users, only: [:show, :update, :destroy]
  resources :employees do
    post 'upload_image', to: 'employees#upload_image'
  end
  resources :teams
  resources :employees_teams
end
