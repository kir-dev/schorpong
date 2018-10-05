Rails.application.routes.draw do
  resources :entries
  resources :memberships
  resources :pages
  resources :events
  resources :teams
  resources :users
  resources :articles

  get '/logout', to: 'sessions#destroy', as: :logout
  get '/login', to: 'sessions#new', as: :login
  get '/auth/oauth/callback', to: 'sessions#create'

  root to: redirect('/users')
end
