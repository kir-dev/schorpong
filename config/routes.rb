Rails.application.routes.draw do
  resources :entries
  resources :pages
  resources :events
  resources :teams do
    resources :memberships
  end
  resources :users
  resources :articles

  post '/logout', to: 'sessions#destroy', as: :logout
  get '/login', to: 'sessions#new', as: :login
  get '/auth/oauth/callback', to: 'sessions#create'

  root to: redirect('/articles')
end
