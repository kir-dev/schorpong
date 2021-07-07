Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  resources :pages, only: [:show, :edit, :update]
  resources :events do
    resources :entries, only: [:create, :destroy] do
      put '/', to: 'entries#toggle_showed_up'
    end
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
  get '/auth/oauth/callback', to: 'sessions#authsch_login'

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  resources :registration, only: [:new, :create]

  get '/signin', to: 'registration#sign_in', as: :sign_in
  post '/login_registered', to: 'sessions#email_login', as: :email_login

  root to: redirect('/')
end
