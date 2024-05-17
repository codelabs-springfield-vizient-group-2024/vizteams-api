Rails.application.routes.draw do
  post 'login', to: 'sessions#create'
  post 'signup', to: 'users#create'
  
  get 'teams/:id/teamemp', to: 'teams#team_emp'

  resources :users, only: [:show, :update, :destroy]
  resources :employees do
    post 'upload_image', to: 'employees#upload_image'
  end
  resources :teams
  resources :employees_teams
  resources :job_titles, only: [:index]
end
