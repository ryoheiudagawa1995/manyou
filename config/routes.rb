Rails.application.routes.draw do
  resources :labels
  get 'sessions/new'
  root to: 'tasks#index'

  resources :tasks
  resources :sessions, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show]

  namespace :admin do
    resources :users
  end
end
