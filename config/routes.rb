Rails.application.routes.draw do
  resources :rents, only: [:new, :index, :create]
  get 'users_rents', to: 'rents#users_index'
  post 'users_rents', to: 'rents#users_index'
  post 'rents_index', to: 'rents#index'

  post 'approve', to: 'rents#approve'
  post 'reject', to: 'rents#reject'
  post 'take', to: 'rents#take'
  post 'return', to: 'rents#return'
  resources :items, only: [:new, :index, :create, :edit, :destroy, :update]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

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
  resources :users, only: [:index, :show, :edit, :update] do
    post :set_animation, on: :collection
  end
  resources :articles
  resources :images, only: [:create]

  get '/', to: 'home#index'

  post '/logout', to: 'sessions#destroy', as: :logout
  get '/login', to: 'sessions#new', as: :login
  get '/auth/oauth/callback', to: 'sessions#create'

  scope :email do
    get '/login', to: 'session_with_email#login_page', as: :email_login_page
    post '/login', to: 'session_with_email#login', as: :email_login
    get '/registration', to: 'session_with_email#registration_page', as: :email_registration_page
    post '/registration', to: 'session_with_email#registration', as: :email_registration
  end
  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all

  root to: redirect('/')
end
