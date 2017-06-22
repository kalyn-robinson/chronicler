Rails.application.routes.draw do
  get 'sessions/new'

  get 'sessions/create'

  get 'sessions/destroy'

  root 'pages#home'

  get '/help',   to: 'pages#help'
  get '/contact', to: 'pages#contact'
  get  '/signup',  to: 'users#new'
  post '/signup',  to: 'users#create'

  resources :users
end
