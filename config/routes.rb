Rails.application.routes.draw do
  root 'pages#home'

  get '/help',   to: 'pages#help'
  get '/contact', to: 'pages#contact'
  get  '/signup',  to: 'users#new'
  
  resources :users
end
