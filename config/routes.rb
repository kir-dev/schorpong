Rails.application.routes.draw do
  resources :entries
  resources :memberships
  resources :pages
  resources :events
  resources :teams
  resources :users
  resources :articles
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
