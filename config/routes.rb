Rails.application.routes.draw do
  post 'login', to: 'sessions#create'
  post 'signup', to: 'users#create'
  get 'teams/:id/teamemp', to: 'teams#team_emp'
  resources :users, only: [:show, :update, :destroy]
  resources :employees
  resources :teams
end
