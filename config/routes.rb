Rails.application.routes.draw do
  get 'relationships/create'
  get 'relationships/destroy'
  resources :labels
  get 'sessions/new'
  root to: 'tasks#index'

  resources :tasks
  resources :sessions, only: %i[new create destroy]
  resources :users, only: %i[index new create show]
  resources :relationships, only: [:create, :destroy]

  resources :conversations do
    resources :messages
  end

  namespace :admin do
    resources :users
  end
end
