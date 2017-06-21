Rails.application.routes.draw do
  get 'users/new'

  root 'pages#home'

  get '/help',   to: 'pages#help'
  get '/contact', to: 'pages#contact'
  
  get  '/signup',  to: 'users#new'
end
