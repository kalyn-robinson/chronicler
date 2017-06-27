Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  root   'pages#home'

  get    '/help',      to: 'pages#help'
  get    '/contact',   to: 'pages#contact'

  get    '/signup',            to: 'users#new'
  post   '/signup',            to: 'users#create'
  patch  '/users/:id/edit',    to: 'users#update'
  post   '/users/:id/restore', to: 'users#restore', as: :restore_user
  
  get    '/login',     to: 'sessions#new'
  post   '/login',     to: 'sessions#create'
  delete '/logout',    to: 'sessions#destroy'

  post   '/characters/new',         to: 'characters#create'
  patch  '/characters/:id/edit',    to: 'characters#update'
  post   '/characters/:id/restore', to: 'characters#restore', as: :restore_character

  resources :users
  resources :characters,          only: [:new, :index, :show, :edit, :destroy]
  resources :password_resets,     only: [:new, :create, :edit]
end
