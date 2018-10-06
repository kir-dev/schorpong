Rails.application.routes.draw do
  resources :pages
  resources :events do
    resources :entries
  end
  resources :teams do
    resources :memberships do
      put '/approve', to: 'memberships#approve'
    end
  end
  resources :users
  resources :articles

  post '/logout', to: 'sessions#destroy', as: :logout
  get '/login', to: 'sessions#new', as: :login
  get '/auth/oauth/callback', to: 'sessions#create'

  root to: redirect('/articles')
end
