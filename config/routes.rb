Rails.application.routes.draw do
  resources :pages, only: [:show, :edit, :update]
  resources :events do
    resources :entries, only: [:create, :destroy]
  end
  resources :teams do
    resources :memberships do
      put '/approve', to: 'memberships#approve'
      delete '/decline', to: 'memberships#decline'
      delete '/destroy', to: 'memberships#destroy'
    end
  end
  resources :users, only: [:index, :show, :edit, :update]
  resources :articles
  resources :images, only: [:create]

  get '/', to: 'home#index'

  post '/logout', to: 'sessions#destroy', as: :logout
  get '/login', to: 'sessions#new', as: :login
  get '/auth/oauth/callback', to: 'sessions#create'

  root to: redirect('/')
end
