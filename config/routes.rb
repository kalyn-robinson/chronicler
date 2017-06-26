Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  root   'pages#home'

  get    '/help',      to: 'pages#help'
  get    '/contact',   to: 'pages#contact'

  get    '/signup',    to: 'users#new'
  post   '/signup',    to: 'users#create'
  post   '/users/:id/restore', to: 'users#restore', as: :restore_user
  
  get    '/login',     to: 'sessions#new'
  post   '/login',     to: 'sessions#create'
  delete '/logout',    to: 'sessions#destroy'

  resources :users
  resources :password_resets,     only: [:new, :create, :edit, :update]
end
